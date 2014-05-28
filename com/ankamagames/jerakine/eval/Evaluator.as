package com.ankamagames.jerakine.eval
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   
   public class Evaluator extends Object
   {
      
      public function Evaluator() {
         super();
      }
      
      protected static const _log:Logger;
      
      private static const NUMBER:uint = 0;
      
      private static const STRING:uint = 1;
      
      public function eval(expr:String) : * {
         return this.complexEval(expr);
      }
      
      private function simpleEval(expr:String) : * {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: TranslateException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      private function complexEval(expr:String) : * {
         var start:* = 0;
         var res:* = undefined;
         var i:uint = 0;
         var expr:String = this.trim(expr);
         var modif:Boolean = true;
         var parenthCount:int = 0;
         loop0:
         while(modif)
         {
            modif = false;
            i = 0;
            while(i < expr.length)
            {
               if(expr.charAt(i) == "(")
               {
                  if(!parenthCount)
                  {
                     start = i;
                  }
                  parenthCount++;
               }
               if(expr.charAt(i) == ")")
               {
                  parenthCount--;
                  if(!parenthCount)
                  {
                     res = this.complexEval(expr.substr(start + 1,i - start - 1));
                     expr = expr.substr(0,start) + (res is Number?res:"\'" + res + "\'") + expr.substr(i + 1);
                     modif = true;
                     continue loop0;
                  }
               }
               i++;
            }
         }
         if(parenthCount)
         {
            _log.warn("Missing right parenthesis in " + expr);
         }
         return this.simpleEval(expr);
      }
      
      private function plus(a:*, b:*) : * {
         return a + b;
      }
      
      private function minus(a:Number, b:Number) : Number {
         return a - b;
      }
      
      private function multiply(a:Number, b:Number) : Number {
         return a * b;
      }
      
      private function divide(a:Number, b:Number) : Number {
         return a / b;
      }
      
      private function sup(a:Number, b:Number) : Number {
         return a > b?1:0;
      }
      
      private function supOrEquals(a:Number, b:Number) : Number {
         return a >= b?1:0;
      }
      
      private function inf(a:Number, b:Number) : Number {
         return a < b?1:0;
      }
      
      private function infOrEquals(a:Number, b:Number) : Number {
         return a <= b?1:0;
      }
      
      private function and(a:Number, b:Number) : Number {
         return (a) && (b)?1:0;
      }
      
      private function or(a:Number, b:Number) : Number {
         return (a) || (b)?1:0;
      }
      
      private function equals(a:*, b:*) : Number {
         return a == b?1:0;
      }
      
      private function diff(a:*, b:*) : Number {
         return a != b?1:0;
      }
      
      private function ternary(cond:Number, a:*, b:*) : * {
         return cond?a:b;
      }
      
      private function opElse() : void {
      }
      
      private function showPosInExpr(pos:uint, expr:String) : String {
         var res:String = expr + "\n";
         var i:uint = 0;
         while(i < pos)
         {
            res = res + " ";
            i++;
         }
         return res + "^";
      }
      
      private function trim(str:String) : String {
         var curChar:String = null;
         var res:String = "";
         var protect:Boolean = false;
         var inQuote:Boolean = false;
         var i:uint = 0;
         while(i < str.length)
         {
            curChar = str.charAt(i);
            if((curChar == "\'") && (!protect))
            {
               inQuote = !inQuote;
            }
            if(curChar == "\\")
            {
               protect = true;
            }
            else
            {
               protect = false;
            }
            if((!(curChar == " ")) || (inQuote))
            {
               res = res + curChar;
            }
            i++;
         }
         return res;
      }
   }
}
