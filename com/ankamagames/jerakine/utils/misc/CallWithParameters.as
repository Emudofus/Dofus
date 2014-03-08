package com.ankamagames.jerakine.utils.misc
{
   public class CallWithParameters extends Object
   {
      
      public function CallWithParameters() {
         super();
      }
      
      public static function call(param1:Function, param2:Array) : void {
         if(!param2 || !param2.length)
         {
            param1();
            return;
         }
         switch(param2.length)
         {
            case 1:
               param1(param2[0]);
               break;
            case 2:
               param1(param2[0],param2[1]);
               break;
            case 3:
               param1(param2[0],param2[1],param2[2]);
               break;
            case 4:
               param1(param2[0],param2[1],param2[2],param2[3]);
               break;
            case 5:
               param1(param2[0],param2[1],param2[2],param2[3],param2[4]);
               break;
            case 6:
               param1(param2[0],param2[1],param2[2],param2[3],param2[4],param2[5]);
               break;
            case 7:
               param1(param2[0],param2[1],param2[2],param2[3],param2[4],param2[5],param2[6]);
               break;
            case 8:
               param1(param2[0],param2[1],param2[2],param2[3],param2[4],param2[5],param2[6],param2[7]);
               break;
            case 9:
               param1(param2[0],param2[1],param2[2],param2[3],param2[4],param2[5],param2[6],param2[7],param2[8]);
               break;
            case 10:
               param1(param2[0],param2[1],param2[2],param2[3],param2[4],param2[5],param2[6],param2[7],param2[8],param2[9]);
               break;
            case 11:
               param1(param2[0],param2[1],param2[2],param2[3],param2[4],param2[5],param2[6],param2[7],param2[8],param2[9],param2[10]);
               break;
            case 12:
               param1(param2[0],param2[1],param2[2],param2[3],param2[4],param2[5],param2[6],param2[7],param2[8],param2[9],param2[10],param2[11]);
               break;
            case 13:
               param1(param2[0],param2[1],param2[2],param2[3],param2[4],param2[5],param2[6],param2[7],param2[8],param2[9],param2[10],param2[11],param2[12]);
               break;
            case 14:
               param1(param2[0],param2[1],param2[2],param2[3],param2[4],param2[5],param2[6],param2[7],param2[8],param2[9],param2[10],param2[11],param2[12],param2[13]);
               break;
            case 15:
               param1(param2[0],param2[1],param2[2],param2[3],param2[4],param2[5],param2[6],param2[7],param2[8],param2[9],param2[10],param2[11],param2[12],param2[13],param2[14]);
               break;
         }
      }
      
      public static function callR(param1:Function, param2:Array) : * {
         if(!param2 || !param2.length)
         {
            return param1();
         }
         switch(param2.length)
         {
            case 1:
               return param1(param2[0]);
            case 2:
               return param1(param2[0],param2[1]);
            case 3:
               return param1(param2[0],param2[1],param2[2]);
            case 4:
               return param1(param2[0],param2[1],param2[2],param2[3]);
            case 5:
               return param1(param2[0],param2[1],param2[2],param2[3],param2[4]);
            case 6:
               return param1(param2[0],param2[1],param2[2],param2[3],param2[4],param2[5]);
            case 7:
               return param1(param2[0],param2[1],param2[2],param2[3],param2[4],param2[5],param2[6]);
            case 8:
               return param1(param2[0],param2[1],param2[2],param2[3],param2[4],param2[5],param2[6],param2[7]);
            case 9:
               return param1(param2[0],param2[1],param2[2],param2[3],param2[4],param2[5],param2[6],param2[7],param2[8]);
            case 10:
               return param1(param2[0],param2[1],param2[2],param2[3],param2[4],param2[5],param2[6],param2[7],param2[8],param2[9]);
            case 11:
               return param1(param2[0],param2[1],param2[2],param2[3],param2[4],param2[5],param2[6],param2[7],param2[8],param2[9],param2[10]);
            case 12:
               return param1(param2[0],param2[1],param2[2],param2[3],param2[4],param2[5],param2[6],param2[7],param2[8],param2[9],param2[10],param2[11]);
            case 13:
               return param1(param2[0],param2[1],param2[2],param2[3],param2[4],param2[5],param2[6],param2[7],param2[8],param2[9],param2[10],param2[11],param2[12]);
            case 14:
               return param1(param2[0],param2[1],param2[2],param2[3],param2[4],param2[5],param2[6],param2[7],param2[8],param2[9],param2[10],param2[11],param2[12],param2[13]);
            case 15:
               return param1(param2[0],param2[1],param2[2],param2[3],param2[4],param2[5],param2[6],param2[7],param2[8],param2[9],param2[10],param2[11],param2[12],param2[13],param2[14]);
            default:
               return;
         }
      }
      
      public static function callConstructor(param1:Class, param2:Array) : * {
         if(!param2 || !param2.length)
         {
            return new param1();
         }
         switch(param2.length)
         {
            case 1:
               return new param1(param2[0]);
            case 2:
               return new param1(param2[0],param2[1]);
            case 3:
               return new param1(param2[0],param2[1],param2[2]);
            case 4:
               return new param1(param2[0],param2[1],param2[2],param2[3]);
            case 5:
               return new param1(param2[0],param2[1],param2[2],param2[3],param2[4]);
            case 6:
               return new param1(param2[0],param2[1],param2[2],param2[3],param2[4],param2[5]);
            case 7:
               return new param1(param2[0],param2[1],param2[2],param2[3],param2[4],param2[5],param2[6]);
            case 8:
               return new param1(param2[0],param2[1],param2[2],param2[3],param2[4],param2[5],param2[6],param2[7]);
            case 9:
               return new param1(param2[0],param2[1],param2[2],param2[3],param2[4],param2[5],param2[6],param2[7],param2[8]);
            case 10:
               return new param1(param2[0],param2[1],param2[2],param2[3],param2[4],param2[5],param2[6],param2[7],param2[8],param2[9]);
            case 11:
               return new param1(param2[0],param2[1],param2[2],param2[3],param2[4],param2[5],param2[6],param2[7],param2[8],param2[9],param2[10]);
            case 12:
               return new param1(param2[0],param2[1],param2[2],param2[3],param2[4],param2[5],param2[6],param2[7],param2[8],param2[9],param2[10],param2[11]);
            case 13:
               return new param1(param2[0],param2[1],param2[2],param2[3],param2[4],param2[5],param2[6],param2[7],param2[8],param2[9],param2[10],param2[11],param2[12]);
            case 14:
               return new param1(param2[0],param2[1],param2[2],param2[3],param2[4],param2[5],param2[6],param2[7],param2[8],param2[9],param2[10],param2[11],param2[12],param2[13]);
            case 15:
               return new param1(param2[0],param2[1],param2[2],param2[3],param2[4],param2[5],param2[6],param2[7],param2[8],param2[9],param2[10],param2[11],param2[12],param2[13],param2[14]);
            default:
               return;
         }
      }
   }
}
