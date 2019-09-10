
// declaring arrays
boolean[][] map;
boolean[][] anti;

// declaring flags and tracking valiables
int size;//sets the size of the array
int map_flag;//tells system which map is in use
int timescale;//sets length of a tick 



void setup()
{
  //sets size of window
  size(500, 500);
  
  //initialisng variables
  map_flag = 0;
  timescale = 20;
  size = 250;
  map = new boolean[size][size];
  anti = new boolean[size][size];

  //setting entire map to false
  for (boolean[] x : map)
  {
      for (boolean y : x)
      {
        y = false;
      }
  }
  
  //setting up the random initial seed ( randomly fills 5% of squares )
  for (int b = 0; b < (((height*width)/(height/size))/100)*5; b++)
  {
      map[int(random(0, size))][int(random(0, size))] = true;
  }
  
}

void draw()
{
  
  background(0);
  fill(0, 255, 0);
  
  for (int i = 0; i < size; i++)
  {
      for (int j = 0; j < size; j++)
      {
          if (map_flag % 2 != 0)
          {
              if (anti[i][j] == true)
              {
                  rect(i*(width/size), j*(width/size), (width/size), (width/size));
              }
          } 
          else
          {
              if (map[i][j] == true)
              {
                  rect(i*(width/size), j*(width/size), (width/size), (width/size));
              }
          }
      }
  }

  if (frameCount % timescale == 0)
  {
      if (map_flag % 2 == 0)
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
                      } 
                      else
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
                  } 
                  else
                  {
                      int count = check_cells(i, j, map);
                      
                      if (count == 3)
                      {
                          anti[i][j] = true;
                      } 
                      else
                      {
                          anti[i][j] = false;
                      }
                  }
              }
          }
      } 
      else
      {
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
                  } 
                  else
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
                  
              } 
              else
              {
                
                int count = check_cells(i, j, anti);
                if (count == 3)
                {
                  map[i][j] = true;
                } 
                else
                {
                  map[i][j] = false;
                }
                
              }
              
          }
          
        }
        
      }
      
    map_flag++;
  }

  fill(255);
  text("ticks:"+map_flag, 10, 10);
  text("timescale:"+timescale, 10, 20);
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
                  } 
                  else
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
  // allows for the timescale to be raised and lowered
  switch(key)
  {
    case 'w':
        timescale++;
        break;
    case 's':
        if (timescale > 1)
        {
            timescale--;
        }
        break;
  }
}
