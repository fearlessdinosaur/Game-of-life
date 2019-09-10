int x;
int y;

boolean[][] map;
boolean[][] anti;
int size;
int sw;
int timescale;
void setup()
{
  size(500, 500);
  sw = 0;
  timescale = 2;
  size = 250;
  map = new boolean[size][size];
  anti = new boolean[size][size];
  
  for (boolean[] x : map)
  {
    for (boolean y : x)
    {
      y = false;
    }
  }
  for (int b = 0; b < 5000; b++)
  {
    map[int(random(0, size))][int(random(0, size))] = true;
  }

  map[10][10] = true;
  map[9][10] = true;
  map[11][10] = true;
}

void draw()
{
  background(0);

  for (int i = 0; i < size; i++)
  {
    for (int j = 0; j < size; j++)
    {
      if (sw % 2 != 0)
      {

        if (anti[i][j] == true)
        {
          fill(0, 255, 0);
          rect(i*2, j*2, 2, 2);
        }
      } else
      {
        if (map[i][j] == true)
        {
          fill(0, 255, 0);
          rect(i*2, j*2, 2, 2);
        }
      }
    }
  }

  if (frameCount % timescale == 0)
  {
    if (sw % 2 == 0)
    {
      for (int i = 0; i < size; i++)
      {
        for (int j = 0; j < size; j++)
        {
          if (map[i][j] == true)
          {
            int count = check_cells(i, j, map);

            if (count == 3 || count == 2)
            {
              anti[i][j] = true;
            } else
            {
              if (count > 3)
              {
                anti[i][j] = false;
              }
              if (count < 2)
              {
                anti[i][j] = false;
              }
            }
          } else
          {
            int count = check_cells(i, j, map);
            if (count == 3)
            {
              anti[i][j] = true;
            } else
            {
              anti[i][j] = false;
            }
          }
        }
      }
    } else
    {
      fill(255);
      for (int i = 0; i < size; i++)
      {
        for (int j = 0; j < size; j++)
        {
          if (anti[i][j] == true)
          {
            int count = check_cells(i, j, anti);
            if (count == 3 || count == 2)
            {
              map[i][j] = true;
            } else
            {
              if (count > 3)
              {

                map[i][j] = false;
              }
              if (count < 2)
              {
                map[i][j] = false;
              }
            }
          } else
          {
            int count = check_cells(i, j, anti);
            if (count == 3)
            {
              map[i][j] = true;
            } else
            {
              map[i][j] = false;
            }
          }
        }
      }
    }
    sw++;
  }
  
  fill(255);
  text("ticks:"+sw,10,10);
  text("timescale:"+timescale,10,20);
}




int check_cells(int x, int y, boolean[][] mp)
{
  int total = 0;
  for (int i = -1; i < 2; i++)
  {
    for (int j = -1; j < 2; j++)
    {
      if (x+i > 0 && x+i < size  && y+j > 0 && y+j < size)
      {
        if (mp[x+i][y+j] == true)
        {
          if (x+i == x && y+j == y)
          {
          } else
          {
            total++;
          }
        }
      }
    }
  }

  return total;
}

void keyPressed()
{
   switch(key)
   {
      case 'w':
        timescale++;
      break;
      case 's':
      if(timescale > 1)
      {
        timescale--;
      }
      break;
   }
}
