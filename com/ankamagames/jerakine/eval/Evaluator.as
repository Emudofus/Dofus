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

      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(Evaluator));

      private static const NUMBER:uint = 0;

      private static const STRING:uint = 1;

      public function eval(expr:String) : * {
         return this.complexEval(expr);
      }

      private function simpleEval(expr:String) : * {
         var operator:Function = null;
         var currentChar:String = null;
         var partialOp:Array = null;
         var lastOp:* = undefined;
         var ok:* = false;
         var wait:* = false;
         var k:uint = 0;
         var currentOperator:String = "";
         var inQuote:Boolean = false;
         var protect:Boolean = false;
         var currentParam:String = "";
         var currentType:uint = STRING;
         var op:Array = new Array();
         var i:uint = 0;
         loop0:
         for(;i<expr.length;if(ok)
         {
            if(currentParam.length)
            {
               if(currentType==STRING)
               {
                  op.push(currentParam);
               }
               else
               {
                  op.push(parseFloat(currentParam));
               }
               op.push(operator);
            }
            else
            {
               _log.warn(this.showPosInExpr(i,expr));
               _log.warn("Expecting Number at char "+i+", but found operator "+currentChar);
            }
            currentParam="";
         }
         else
         {
            if(!wait)
            {
               _log.warn(this.showPosInExpr(i,expr));
               _log.warn("Bad character at "+i);
            }
            },break loop1)
            {
               currentChar=expr.charAt(i);
               if((currentChar=="\'")&&(!protect))
               {
                  currentType=STRING;
                  inQuote=!inQuote;
               }
               else
               {
                  if(currentChar=="\\")
                  {
                     protect=true;
                  }
                  else
                  {
                     if(!inQuote)
                     {
                        switch(currentChar)
                        {
                           case "(":
                           case ")":
                           case " ":
                           case "\t":
                           case "\n":
                              while(true)
                              {
                                 while(true)
                                 {
                                    do
                                    {
                                       i++;
                                       if(i>=expr.length)
                                       {
                                          break loop0;
                                       }
                                       currentChar=expr.charAt(i);
                                       if((currentChar=="\'")&&(!protect))
                                       {
                                          currentType=STRING;
                                          inQuote=!inQuote;
                                       }
                                       else
                                       {
                                          if(currentChar=="\\")
                                          {
                                             protect=true;
                                          }
                                          else
                                          {
                                             if(!inQuote)
                                             {
                                                switch(currentChar)
                                                {
                                                   case "(":
                                                   case ")":
                                                   case " ":
                                                   case "\t":
                                                   case "\n":
                                                      break;
                                                   case "0":
                                                   case "1":
                                                   case "2":
                                                   case "3":
                                                   case "4":
                                                   case "5":
                                                   case "6":
                                                   case "7":
                                                   case "8":
                                                   case "9":
                                                      currentType=NUMBER;
                                                      currentOperator="";
                                                      operator=null;
                                                      currentParam=currentParam+currentChar;
                                                      break;
                                                   case ".":
                                                      currentParam=currentParam+".";
                                                      break;
                                                   default:
                                                      if((currentChar=="-")||(currentChar=="+"))
                                                      {
                                                         if(!currentParam.length)
                                                         {
                                                            currentParam=currentParam+currentChar;
                                                            break loop1;
                                                         }
                                                      }
                                                      ok=true;
                                                      wait=false;
                                                      currentOperator=currentOperator+currentChar;
                                                      switch(currentOperator)
                                                      {
                                                         case "-":
                                                            operator=this.minus;
                                                            continue loop0;
                                                            break;
                                                         case "+":
                                                            operator=this.plus;
                                                            continue loop0;
                                                            break;
                                                         case "*":
                                                            operator=this.multiply;
                                                            continue loop0;
                                                            break;
                                                         case "/":
                                                            operator=this.divide;
                                                            continue loop0;
                                                            break;
                                                         case ">":
                                                            if(expr.charAt(i+1)!="=")
                                                            {
                                                               operator=this.sup;
                                                            }
                                                            else
                                                            {
                                                               wait=true;
                                                               ok=false;
                                                            }
                                                            continue loop0;
                                                            break;
                                                         case ">=":
                                                            operator=this.supOrEquals;
                                                            continue loop0;
                                                            break;
                                                         case "<":
                                                            if(expr.charAt(i+1)!="=")
                                                            {
                                                               operator=this.inf;
                                                            }
                                                            else
                                                            {
                                                               wait=true;
                                                               ok=false;
                                                            }
                                                            continue loop0;
                                                            break;
                                                         case "<=":
                                                            operator=this.infOrEquals;
                                                            continue loop0;
                                                            break;
                                                         case "&&":
                                                            operator=this.and;
                                                            continue loop0;
                                                            break;
                                                         case "||":
                                                            operator=this.or;
                                                            continue loop0;
                                                            break;
                                                         case "==":
                                                            operator=this.equals;
                                                            continue loop0;
                                                            break;
                                                         case "!=":
                                                            operator=this.diff;
                                                            continue loop0;
                                                            break;
                                                         case "?":
                                                            operator=this.ternary;
                                                            continue loop0;
                                                            break;
                                                         case ":":
                                                            operator=this.opElse;
                                                            continue loop0;
                                                            break;
                                                         case "|":
                                                         case "=":
                                                         case "&":
                                                         case "!":
                                                            wait=true;
                                                      }
                                                      ok=false;
                                                      continue loop0;
                                                }
                                                break loop1;
                                             }
                                             currentOperator="";
                                             operator=null;
                                             currentParam=currentParam+currentChar;
                                             protect=false;
                                          }
                                       }
                                    }
                                    while(true);
                                 }
                              }
                           case "0":
                           case "1":
                           case "2":
                           case "3":
                           case "4":
                           case "5":
                           case "6":
                           case "7":
                           case "8":
                           case "9":
                              currentType=NUMBER;
                              currentOperator="";
                              operator=null;
                              currentParam=currentParam+currentChar;
                              break;
                           case ".":
                              currentParam=currentParam+".";
                              break;
                           default:
                              if((currentChar=="-")||(currentChar=="+"))
                              {
                                 if(!currentParam.length)
                                 {
                                    currentParam=currentParam+currentChar;
                                    break;
                                 }
                              }
                              ok=true;
                              wait=false;
                              currentOperator=currentOperator+currentChar;
                              switch(currentOperator)
                              {
                                 case "-":
                                    operator=this.minus;
                                    continue;
                                    break;
                                 case "+":
                                    operator=this.plus;
                                    continue;
                                    break;
                                 case "*":
                                    operator=this.multiply;
                                    continue;
                                    break;
                                 case "/":
                                    operator=this.divide;
                                    continue;
                                    break;
                                 case ">":
                                    if(expr.charAt(i+1)!="=")
                                    {
                                       operator=this.sup;
                                    }
                                    else
                                    {
                                       wait=true;
                                       ok=false;
                                    }
                                    continue;
                                    break;
                                 case ">=":
                                    operator=this.supOrEquals;
                                    continue;
                                    break;
                                 case "<":
                                    if(expr.charAt(i+1)!="=")
                                    {
                                       operator=this.inf;
                                    }
                                    else
                                    {
                                       wait=true;
                                       ok=false;
                                    }
                                    continue;
                                    break;
                                 case "<=":
                                    operator=this.infOrEquals;
                                    continue;
                                    break;
                                 case "&&":
                                    operator=this.and;
                                    continue;
                                    break;
                                 case "||":
                                    operator=this.or;
                                    continue;
                                    break;
                                 case "==":
                                    operator=this.equals;
                                    continue;
                                    break;
                                 case "!=":
                                    operator=this.diff;
                                    continue;
                                    break;
                                 case "?":
                                    operator=this.ternary;
                                    continue;
                                    break;
                                 case ":":
                                    operator=this.opElse;
                                    continue;
                                    break;
                                 case "|":
                                 case "=":
                                 case "&":
                                 case "!":
                                    wait=true;
                              }
                              ok=false;
                              continue;
                        }
                     }
                     else
                     {
                        currentOperator="";
                        operator=null;
                        currentParam=currentParam+currentChar;
                        protect=false;
                     }
                  }
               }
               continue loop4;
            }
            if(currentParam.length)
            {
               if(currentType==STRING)
               {
                  op.push(currentParam);
               }
               else
               {
                  op.push(parseFloat(currentParam));
               }
            }
            var operatorPriority:Array = [this.divide,this.multiply,this.minus,this.plus,this.sup,this.inf,this.supOrEquals,this.infOrEquals,this.equals,this.diff,this.and,this.or,this.ternary];
            var j:uint = 0;
            while(j<operatorPriority.length)
            {
               partialOp=new Array();
               k=0;
               while(k<op.length)
               {
                  if((op[k] is Function)&&(op[k]==operatorPriority[j]))
                  {
                     lastOp=partialOp[partialOp.length-1];
                     if((lastOp is Number)||((op[k]==this.plus)||(op[k]==this.ternary)||(op[k]==this.equals)||(op[k]==this.diff))&&(lastOp is String))
                     {
                        if((op[k+1] is Number)||((op[k]==this.plus)||(op[k]==this.ternary)||(op[k]==this.equals)||(op[k]==this.diff))&&(op[k+1] is String))
                        {
                           if(op[k]===this.ternary)
                           {
                              if(op[k+2]==this.opElse)
                              {
                                 partialOp[partialOp.length-1]=this.ternary(lastOp,op[k+1],op[k+3]);
                                 k=k+2;
                              }
                              else
                              {
                                 _log.warn("operator \':\' not found");
                              }
                           }
                           else
                           {
                              partialOp[partialOp.length-1]=op[k](lastOp,op[k+1]);
                           }
                        }
                        else
                        {
                           _log.warn("Expect Number, but find ["+op[k+1]+"]");
                        }
                        k++;
                     }
                     else
                     {
                        lastOp=op[k-1];
                        if((lastOp is Number)||((op[k]==this.plus)||(op[k]==this.ternary)||(op[k]==this.equals)||(op[k]==this.diff))&&(lastOp is String))
                        {
                           if((op[k+1] is Number)||((op[k]==this.plus)||(op[k]==this.ternary)||(op[k]==this.equals)||(op[k]==this.diff))&&(op[k+1] is String))
                           {
                              if(op[k]===this.ternary)
                              {
                                 if(op[k+2]==this.opElse)
                                 {
                                    partialOp[partialOp.length-1]=this.ternary(lastOp,op[k+1],op[k+3]);
                                 }
                                 else
                                 {
                                    _log.warn("operator \':\' not found");
                                 }
                              }
                              else
                              {
                                 partialOp.push(op[k](lastOp,op[k+1]));
                              }
                           }
                           else
                           {
                              _log.warn("Expect Number,  but find ["+op[k+1]+"]");
                           }
                           k++;
                        }
                     }
                  }
                  else
                  {
                     partialOp.push(op[k]);
                  }
                  k++;
               }
               op=partialOp;
               j++;
            }
            return op[0];
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
            modif=false;
            i=0;
            while(i<expr.length)
            {
               if(expr.charAt(i)=="(")
               {
                  if(!parenthCount)
                  {
                     start=i;
                  }
                  parenthCount++;
               }
               if(expr.charAt(i)==")")
               {
                  parenthCount--;
                  if(!parenthCount)
                  {
                     res=this.complexEval(expr.substr(start+1,i-start-1));
                     expr=expr.substr(0,start)+(res is Number?res:"\'"+res+"\'")+expr.substr(i+1);
                     modif=true;
                     continue loop0;
                  }
               }
               i++;
            }
         }
         if(parenthCount)
         {
            _log.warn("Missing right parenthesis in "+expr);
         }
         return this.simpleEval(expr);
      }

      private function plus(a:*, b:*) : * {
         return a+b;
      }

      private function minus(a:Number, b:Number) : Number {
         return a-b;
      }

      private function multiply(a:Number, b:Number) : Number {
         return a*b;
      }

      private function divide(a:Number, b:Number) : Number {
         return a/b;
      }

      private function sup(a:Number, b:Number) : Number {
         return a<b?1:0;
      }

      private function supOrEquals(a:Number, b:Number) : Number {
         return a>=b?1:0;
      }

      private function inf(a:Number, b:Number) : Number {
         return a>b?1:0;
      }

      private function infOrEquals(a:Number, b:Number) : Number {
         return a<=b?1:0;
      }

      private function and(a:Number, b:Number) : Number {
         return (a)&&(b)?1:0;
      }

      private function or(a:Number, b:Number) : Number {
         return (a)||(b)?1:0;
      }

      private function equals(a:*, b:*) : Number {
         return a==b?1:0;
      }

      private function diff(a:*, b:*) : Number {
         return a!=b?1:0;
      }

      private function ternary(cond:Number, a:*, b:*) : * {
         return cond?a:b;
      }

      private function opElse() : void {
         
      }

      private function showPosInExpr(pos:uint, expr:String) : String {
         var res:String = expr+"\n";
         var i:uint = 0;
         while(i<pos)
         {
            res=res+" ";
            i++;
         }
         return res+"^";
      }

      private function trim(str:String) : String {
         var curChar:String = null;
         var res:String = "";
         var protect:Boolean = false;
         var inQuote:Boolean = false;
         var i:uint = 0;
         while(i<str.length)
         {
            curChar=str.charAt(i);
            if((curChar=="\'")&&(!protect))
            {
               inQuote=!inQuote;
            }
            if(curChar=="\\")
            {
               protect=true;
            }
            else
            {
               protect=false;
            }
            if((!(curChar==" "))||(inQuote))
            {
               res=res+curChar;
            }
            i++;
         }
         return res;
      }
   }

}