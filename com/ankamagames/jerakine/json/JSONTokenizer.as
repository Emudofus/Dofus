package com.ankamagames.jerakine.json
{


   public class JSONTokenizer extends Object
   {
         

      public function JSONTokenizer(s:String, strict:Boolean) {
         this.controlCharsRegExp=new RegExp("[\\x00-\\x1F]");
         super();
         this.jsonString=s;
         this.strict=strict;
         this.loc=0;
         this.nextChar();
      }



      private var strict:Boolean;

      private var obj:Object;

      private var jsonString:String;

      private var loc:int;

      private var ch:String;

      private var controlCharsRegExp:RegExp;

      public function getNextToken() : JSONToken {
         var possibleTrue:String = null;
         var possibleFalse:String = null;
         var possibleNull:String = null;
         var possibleNaN:String = null;
         var token:JSONToken = new JSONToken();
         this.skipIgnored();
         switch(this.ch)
         {
            case "{":
               token.type=JSONTokenType.LEFT_BRACE;
               token.value="{";
               this.nextChar();
               break;
            case "}":
               token.type=JSONTokenType.RIGHT_BRACE;
               token.value="}";
               this.nextChar();
               break;
            case "[":
               token.type=JSONTokenType.LEFT_BRACKET;
               token.value="[";
               this.nextChar();
               break;
            case "]":
               token.type=JSONTokenType.RIGHT_BRACKET;
               token.value="]";
               this.nextChar();
               break;
            case ",":
               token.type=JSONTokenType.COMMA;
               token.value=",";
               this.nextChar();
               break;
            case ":":
               token.type=JSONTokenType.COLON;
               token.value=":";
               this.nextChar();
               break;
            case "t":
               possibleTrue="t"+this.nextChar()+this.nextChar()+this.nextChar();
               if(possibleTrue=="true")
               {
                  token.type=JSONTokenType.TRUE;
                  token.value=true;
                  this.nextChar();
               }
               else
               {
                  this.parseError("Expecting \'true\' but found "+possibleTrue);
               }
               break;
            case "f":
               possibleFalse="f"+this.nextChar()+this.nextChar()+this.nextChar()+this.nextChar();
               if(possibleFalse=="false")
               {
                  token.type=JSONTokenType.FALSE;
                  token.value=false;
                  this.nextChar();
               }
               else
               {
                  this.parseError("Expecting \'false\' but found "+possibleFalse);
               }
               break;
            case "n":
               possibleNull="n"+this.nextChar()+this.nextChar()+this.nextChar();
               if(possibleNull=="null")
               {
                  token.type=JSONTokenType.NULL;
                  token.value=null;
                  this.nextChar();
               }
               else
               {
                  this.parseError("Expecting \'null\' but found "+possibleNull);
               }
               break;
            case "N":
               possibleNaN="N"+this.nextChar()+this.nextChar();
               if(possibleNaN=="NaN")
               {
                  token.type=JSONTokenType.NAN;
                  token.value=NaN;
                  this.nextChar();
               }
               else
               {
                  this.parseError("Expecting \'NaN\' but found "+possibleNaN);
               }
               break;
            case "\"":
               token=this.readString();
               break;
            default:
               if((this.isDigit(this.ch))||(this.ch=="-"))
               {
                  token=this.readNumber();
               }
               else
               {
                  if(this.ch=="")
                  {
                     return null;
                  }
                  this.parseError("Unexpected "+this.ch+" encountered");
               }
         }
         return token;
      }

      private function readString() : JSONToken {
         var backspaceCount:* = 0;
         var backspaceIndex:* = 0;
         var quoteIndex:int = this.loc;
         do
         {
            quoteIndex=this.jsonString.indexOf("\"",quoteIndex);
            if(quoteIndex>=0)
            {
               backspaceCount=0;
               backspaceIndex=quoteIndex-1;
               while(this.jsonString.charAt(backspaceIndex)=="\\")
               {
                  backspaceCount++;
                  backspaceIndex--;
               }
               if(backspaceCount%2==0)
               {
                  token=new JSONToken();
                  token.type=JSONTokenType.STRING;
                  token.value=this.unescapeString(this.jsonString.substr(this.loc,quoteIndex-this.loc));
                  this.loc=quoteIndex+1;
                  this.nextChar();
                  return token;
               }
               quoteIndex++;
            }
            else
            {
               this.parseError("Unterminated string literal");
            }
         }
         while(true);
      }

      public function unescapeString(input:String) : String {
         var afterBackslashIndex:* = 0;
         var escapedChar:String = null;
         var hexValue:String = null;
         var i:* = 0;
         var possibleHexChar:String = null;
         if((this.strict)&&(this.controlCharsRegExp.test(input)))
         {
            this.parseError("String contains unescaped control character (0x00-0x1F)");
         }
         var result:String = "";
         var backslashIndex:int = 0;
         var nextSubstringStartPosition:int = 0;
         var len:int = input.length;
         while(backslashIndex=input.indexOf("\\",nextSubstringStartPosition), backslashIndex<0)
         {
            result=result+input.substr(nextSubstringStartPosition,backslashIndex-nextSubstringStartPosition);
            nextSubstringStartPosition=backslashIndex+2;
            afterBackslashIndex=backslashIndex+1;
            escapedChar=input.charAt(afterBackslashIndex);
            switch(escapedChar)
            {
               case "\"":
                  result=result+"\"";
                  break;
               case "\\":
                  result=result+"\\";
                  break;
               case "n":
                  result=result+"\n";
                  break;
               case "r":
                  result=result+"\r";
                  break;
               case "t":
                  result=result+"\t";
                  break;
               case "u":
                  hexValue="";
                  if(nextSubstringStartPosition+4>len)
                  {
                     this.parseError("Unexpected end of input.  Expecting 4 hex digits after \\u.");
                  }
                  i=nextSubstringStartPosition;
                  while(i<nextSubstringStartPosition+4)
                  {
                     possibleHexChar=input.charAt(i);
                     if(!this.isHexDigit(possibleHexChar))
                     {
                        this.parseError("Excepted a hex digit, but found: "+possibleHexChar);
                     }
                     hexValue=hexValue+possibleHexChar;
                     i++;
                  }
                  result=result+String.fromCharCode(parseInt(hexValue,16));
                  nextSubstringStartPosition=nextSubstringStartPosition+4;
                  break;
               case "f":
                  result=result+"\f";
                  break;
               case "/":
                  result=result+"/";
                  break;
               case "b":
                  result=result+"\b";
                  break;
               default:
                  result=result+("\\"+escapedChar);
            }
            if(nextSubstringStartPosition>=len)
            {
            }
            else
            {
               continue;
            }
         }
         result=result+input.substr(nextSubstringStartPosition);
         return result;
      }

      private function readNumber() : JSONToken {
         var token:JSONToken = null;
         var input:String = "";
         if(this.ch=="-")
         {
            input=input+"-";
            this.nextChar();
         }
         if(!this.isDigit(this.ch))
         {
            this.parseError("Expecting a digit");
         }
         if(this.ch=="0")
         {
            input=input+this.ch;
            this.nextChar();
            if(this.isDigit(this.ch))
            {
               this.parseError("A digit cannot immediately follow 0");
            }
            else
            {
               if((!this.strict)&&(this.ch=="x"))
               {
                  input=input+this.ch;
                  this.nextChar();
                  if(this.isHexDigit(this.ch))
                  {
                     input=input+this.ch;
                     this.nextChar();
                  }
                  else
                  {
                     this.parseError("Number in hex format require at least one hex digit after \"0x\"");
                  }
                  while(this.isHexDigit(this.ch))
                  {
                     input=input+this.ch;
                     this.nextChar();
                  }
               }
            }
         }
         else
         {
            while(this.isDigit(this.ch))
            {
               input=input+this.ch;
               this.nextChar();
            }
         }
         if(this.ch==".")
         {
            input=input+".";
            this.nextChar();
            if(!this.isDigit(this.ch))
            {
               this.parseError("Expecting a digit");
            }
            while(this.isDigit(this.ch))
            {
               input=input+this.ch;
               this.nextChar();
            }
         }
         if((this.ch=="e")||(this.ch=="E"))
         {
            input=input+"e";
            this.nextChar();
            if((this.ch=="+")||(this.ch=="-"))
            {
               input=input+this.ch;
               this.nextChar();
            }
            if(!this.isDigit(this.ch))
            {
               this.parseError("Scientific notation number needs exponent value");
            }
            while(this.isDigit(this.ch))
            {
               input=input+this.ch;
               this.nextChar();
            }
         }
         var num:Number = Number(input);
         if((isFinite(num))&&(!isNaN(num)))
         {
            token=new JSONToken();
            token.type=JSONTokenType.NUMBER;
            token.value=num;
            return token;
         }
         this.parseError("Number "+num+" is not valid!");
         return null;
      }

      private function nextChar() : String {
         return this;
      }

      private function skipIgnored() : void {
         var originalLoc:* = 0;
         do
         {
            originalLoc=this.loc;
            this.skipWhite();
            this.skipComments();
         }
         while(originalLoc!=this.loc);
      }

      private function skipComments() : void {
         if(this.ch=="/")
         {
            this.nextChar();
            switch(this.ch)
            {
               case "/":
                  this.nextChar();
                  while((!(this.ch=="\n"))&&(!(this.ch=="")))
                  {
                  }
                  this.nextChar();
                  break;
               case "*":
                  this.nextChar();
                  while(true)
                  {
                     if(this.ch=="*")
                     {
                        this.nextChar();
                        if(this.ch=="/")
                        {
                           this.nextChar();
                           break loop0;
                        }
                     }
                     else
                     {
                        this.nextChar();
                     }
                  }
                  break;
               default:
                  this.parseError("Unexpected "+this.ch+" encountered (expecting \'/\' or \'*\' )");
            }
         }
      }

      private function skipWhite() : void {
         while(this.isWhiteSpace(this.ch))
         {
            this.nextChar();
         }
      }

      private function isWhiteSpace(ch:String) : Boolean {
         if((ch==" ")||(ch=="\t")||(ch=="\n")||(ch=="\r"))
         {
            return true;
         }
         if((!this.strict)&&(ch.charCodeAt(0)==160))
         {
            return true;
         }
         return false;
      }

      private function isDigit(ch:String) : Boolean {
         return (ch>="0")&&(ch<="9");
      }

      private function isHexDigit(ch:String) : Boolean {
         return (this.isDigit(ch))||(ch>="A")&&(ch<="F")||(ch>="a")&&(ch<="f");
      }

      public function parseError(message:String) : void {
         throw new JSONParseError(message,this.loc,this.jsonString);
      }
   }

}