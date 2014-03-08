package com.ankamagames.jerakine.utils.display
{
   import com.ankamagames.jerakine.types.Point3D;
   import flash.geom.Point;
   
   public class Dofus1Line extends Object
   {
      
      public function Dofus1Line() {
         super();
      }
      
      public static function getLine(x1:int, y1:int, z1:int, x2:int, y2:int, z2:int) : Array {
         var i:* = 0;
         var pStart:Point3D = null;
         var cell:Point = null;
         var erreurSupArrondis:* = 0;
         var erreurInfArrondis:* = 0;
         var beforeY:* = NaN;
         var afterY:* = NaN;
         var diffBeforeCenterY:* = NaN;
         var diffCenterAfterY:* = NaN;
         var beforeX:* = NaN;
         var afterX:* = NaN;
         var diffBeforeCenterX:* = NaN;
         var diffCenterAfterX:* = NaN;
         var y:uint = 0;
         var x:uint = 0;
         var line:Array = new Array();
         var pFrom:Point3D = new Point3D(x1,y1,z1);
         var pTo:Point3D = new Point3D(x2,y2,z2);
         pStart = new Point3D(pFrom.x + 0.5,pFrom.y + 0.5,pFrom.z);
         var pEnd:Point3D = new Point3D(pTo.x + 0.5,pTo.y + 0.5,pTo.z);
         var padX:Number = 0;
         var padY:Number = 0;
         var padZ:Number = 0;
         var steps:Number = 0;
         var descending:Boolean = pStart.z > pEnd.z;
         var xToTest:Array = new Array();
         var yToTest:Array = new Array();
         var cas:uint = 0;
         if(Math.abs(pStart.x - pEnd.x) == Math.abs(pStart.y - pEnd.y))
         {
            steps = Math.abs(pStart.x - pEnd.x);
            padX = pEnd.x > pStart.x?1:-1;
            padY = pEnd.y > pStart.y?1:-1;
            padZ = steps == 0?0:descending?(pFrom.z - pTo.z) / steps:(pTo.z - pFrom.z) / steps;
            cas = 1;
         }
         else
         {
            if(Math.abs(pStart.x - pEnd.x) > Math.abs(pStart.y - pEnd.y))
            {
               steps = Math.abs(pStart.x - pEnd.x);
               padX = pEnd.x > pStart.x?1:-1;
               padY = pEnd.y > pStart.y?Math.abs(pStart.y - pEnd.y) == 0?0:Math.abs(pStart.y - pEnd.y) / steps:-Math.abs(pStart.y - pEnd.y) / steps;
               padY = padY * 100;
               padY = Math.ceil(padY) / 100;
               padZ = steps == 0?0:descending?(pFrom.z - pTo.z) / steps:(pTo.z - pFrom.z) / steps;
               cas = 2;
            }
            else
            {
               steps = Math.abs(pStart.y - pEnd.y);
               padX = pEnd.x > pStart.x?Math.abs(pStart.x - pEnd.x) == 0?0:Math.abs(pStart.x - pEnd.x) / steps:-Math.abs(pStart.x - pEnd.x) / steps;
               padX = padX * 100;
               padX = Math.ceil(padX) / 100;
               padY = pEnd.y > pStart.y?1:-1;
               padZ = steps == 0?0:descending?(pFrom.z - pTo.z) / steps:(pTo.z - pFrom.z) / steps;
               cas = 3;
            }
         }
         i = 0;
         while(i < steps)
         {
            erreurSupArrondis = int(3 + steps / 2);
            erreurInfArrondis = int(97 - steps / 2);
            if(cas == 2)
            {
               beforeY = Math.ceil(pStart.y * 100 + padY * 50) / 100;
               afterY = Math.floor(pStart.y * 100 + padY * 150) / 100;
               diffBeforeCenterY = Math.floor(Math.abs(Math.floor(beforeY) * 100 - beforeY * 100)) / 100;
               diffCenterAfterY = Math.ceil(Math.abs(Math.ceil(afterY) * 100 - afterY * 100)) / 100;
               if(Math.floor(beforeY) == Math.floor(afterY))
               {
                  yToTest = [Math.floor(pStart.y + padY)];
                  if((beforeY == yToTest[0]) && (afterY < yToTest[0]))
                  {
                     yToTest = [Math.ceil(pStart.y + padY)];
                  }
                  else
                  {
                     if((beforeY == yToTest[0]) && (afterY > yToTest[0]))
                     {
                        yToTest = [Math.floor(pStart.y + padY)];
                     }
                     else
                     {
                        if((afterY == yToTest[0]) && (beforeY < yToTest[0]))
                        {
                           yToTest = [Math.ceil(pStart.y + padY)];
                        }
                        else
                        {
                           if((afterY == yToTest[0]) && (beforeY > yToTest[0]))
                           {
                              yToTest = [Math.floor(pStart.y + padY)];
                           }
                        }
                     }
                  }
               }
               else
               {
                  if(Math.ceil(beforeY) == Math.ceil(afterY))
                  {
                     yToTest = [Math.ceil(pStart.y + padY)];
                     if((beforeY == yToTest[0]) && (afterY < yToTest[0]))
                     {
                        yToTest = [Math.floor(pStart.y + padY)];
                     }
                     else
                     {
                        if((beforeY == yToTest[0]) && (afterY > yToTest[0]))
                        {
                           yToTest = [Math.ceil(pStart.y + padY)];
                        }
                        else
                        {
                           if((afterY == yToTest[0]) && (beforeY < yToTest[0]))
                           {
                              yToTest = [Math.floor(pStart.y + padY)];
                           }
                           else
                           {
                              if((afterY == yToTest[0]) && (beforeY > yToTest[0]))
                              {
                                 yToTest = [Math.ceil(pStart.y + padY)];
                              }
                           }
                        }
                     }
                  }
                  else
                  {
                     if(int(diffBeforeCenterY * 100) <= erreurSupArrondis)
                     {
                        yToTest = [Math.floor(afterY)];
                     }
                     else
                     {
                        if(int(diffCenterAfterY * 100) >= erreurInfArrondis)
                        {
                           yToTest = [Math.floor(beforeY)];
                        }
                        else
                        {
                           yToTest = [Math.floor(beforeY),Math.floor(afterY)];
                        }
                     }
                  }
               }
            }
            else
            {
               if(cas == 3)
               {
                  beforeX = Math.ceil(pStart.x * 100 + padX * 50) / 100;
                  afterX = Math.floor(pStart.x * 100 + padX * 150) / 100;
                  diffBeforeCenterX = Math.floor(Math.abs(Math.floor(beforeX) * 100 - beforeX * 100)) / 100;
                  diffCenterAfterX = Math.ceil(Math.abs(Math.ceil(afterX) * 100 - afterX * 100)) / 100;
                  if(Math.floor(beforeX) == Math.floor(afterX))
                  {
                     xToTest = [Math.floor(pStart.x + padX)];
                     if((beforeX == xToTest[0]) && (afterX < xToTest[0]))
                     {
                        xToTest = [Math.ceil(pStart.x + padX)];
                     }
                     else
                     {
                        if((beforeX == xToTest[0]) && (afterX > xToTest[0]))
                        {
                           xToTest = [Math.floor(pStart.x + padX)];
                        }
                        else
                        {
                           if((afterX == xToTest[0]) && (beforeX < xToTest[0]))
                           {
                              xToTest = [Math.ceil(pStart.x + padX)];
                           }
                           else
                           {
                              if((afterX == xToTest[0]) && (beforeX > xToTest[0]))
                              {
                                 xToTest = [Math.floor(pStart.x + padX)];
                              }
                           }
                        }
                     }
                  }
                  else
                  {
                     if(Math.ceil(beforeX) == Math.ceil(afterX))
                     {
                        xToTest = [Math.ceil(pStart.x + padX)];
                        if((beforeX == xToTest[0]) && (afterX < xToTest[0]))
                        {
                           xToTest = [Math.floor(pStart.x + padX)];
                        }
                        else
                        {
                           if((beforeX == xToTest[0]) && (afterX > xToTest[0]))
                           {
                              xToTest = [Math.ceil(pStart.x + padX)];
                           }
                           else
                           {
                              if((afterX == xToTest[0]) && (beforeX < xToTest[0]))
                              {
                                 xToTest = [Math.floor(pStart.x + padX)];
                              }
                              else
                              {
                                 if((afterX == xToTest[0]) && (beforeX > xToTest[0]))
                                 {
                                    xToTest = [Math.ceil(pStart.x + padX)];
                                 }
                              }
                           }
                        }
                     }
                     else
                     {
                        if(int(diffBeforeCenterX * 100) <= erreurSupArrondis)
                        {
                           xToTest = [Math.floor(afterX)];
                        }
                        else
                        {
                           if(int(diffCenterAfterX * 100) >= erreurInfArrondis)
                           {
                              xToTest = [Math.floor(beforeX)];
                           }
                           else
                           {
                              xToTest = [Math.floor(beforeX),Math.floor(afterX)];
                           }
                        }
                     }
                  }
               }
            }
            if(yToTest.length > 0)
            {
               y = 0;
               while(y < yToTest.length)
               {
                  cell = new Point(Math.floor(pStart.x + padX),yToTest[y]);
                  line.push(cell);
                  y++;
               }
            }
            else
            {
               if(xToTest.length > 0)
               {
                  x = 0;
                  while(x < xToTest.length)
                  {
                     cell = new Point(xToTest[x],Math.floor(pStart.y + padY));
                     line.push(cell);
                     x++;
                  }
               }
               else
               {
                  if(cas == 1)
                  {
                     cell = new Point(Math.floor(pStart.x + padX),Math.floor(pStart.y + padY));
                     line.push(cell);
                  }
               }
            }
            pStart.x = (pStart.x * 100 + padX * 100) / 100;
            pStart.y = (pStart.y * 100 + padY * 100) / 100;
            i++;
         }
         return line;
      }
   }
}
