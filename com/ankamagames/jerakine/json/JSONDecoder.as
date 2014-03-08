package com.ankamagames.jerakine.json
{
   public class JSONDecoder extends Object
   {
      
      public function JSONDecoder(s:String, strict:Boolean) {
         super();
         this.strict = strict;
         this.tokenizer = new JSONTokenizer(s,strict);
         this.nextToken();
         this.value = this.parseValue();
         if((strict) && (!(this.nextToken() == null)))
         {
            this.tokenizer.parseError("Unexpected characters left in input stream");
         }
      }
      
      private var strict:Boolean;
      
      private var value;
      
      private var tokenizer:JSONTokenizer;
      
      private var token:JSONToken;
      
      public function getValue() : * {
         return this.value;
      }
      
      private function nextToken() : JSONToken {
         return this.token = this.tokenizer.getNextToken();
      }
      
      private function parseArray() : Array {
         var a:Array = new Array();
         this.nextToken();
         if(this.token.type == JSONTokenType.RIGHT_BRACKET)
         {
            return a;
         }
         if((!this.strict) && (this.token.type == JSONTokenType.COMMA))
         {
            this.nextToken();
            if(this.token.type == JSONTokenType.RIGHT_BRACKET)
            {
               return a;
            }
            this.tokenizer.parseError("Leading commas are not supported.  Expecting \']\' but found " + this.token.value);
         }
         while(true)
         {
            a.push(this.parseValue());
            this.nextToken();
            if(this.token.type == JSONTokenType.RIGHT_BRACKET)
            {
               return a;
            }
            if(this.token.type == JSONTokenType.COMMA)
            {
               this.nextToken();
               if(!this.strict)
               {
                  if(this.token.type == JSONTokenType.RIGHT_BRACKET)
                  {
                     return a;
                  }
               }
            }
            else
            {
               this.tokenizer.parseError("Expecting ] or , but found " + this.token.value);
            }
         }
         return null;
      }
      
      private function parseObject() : Object {
         var key:String = null;
         var o:Object = new Object();
         this.nextToken();
         if(this.token.type == JSONTokenType.RIGHT_BRACE)
         {
            return o;
         }
         if((!this.strict) && (this.token.type == JSONTokenType.COMMA))
         {
            this.nextToken();
            if(this.token.type == JSONTokenType.RIGHT_BRACE)
            {
               return o;
            }
            this.tokenizer.parseError("Leading commas are not supported.  Expecting \'}\' but found " + this.token.value);
         }
         while(true)
         {
            if(this.token.type == JSONTokenType.STRING)
            {
               key = String(this.token.value);
               this.nextToken();
               if(this.token.type == JSONTokenType.COLON)
               {
                  this.nextToken();
                  o[key] = this.parseValue();
                  this.nextToken();
                  if(this.token.type == JSONTokenType.RIGHT_BRACE)
                  {
                     return o;
                  }
                  if(this.token.type == JSONTokenType.COMMA)
                  {
                     this.nextToken();
                     if(!this.strict)
                     {
                        if(this.token.type == JSONTokenType.RIGHT_BRACE)
                        {
                           return o;
                        }
                     }
                  }
                  else
                  {
                     this.tokenizer.parseError("Expecting } or , but found " + this.token.value);
                  }
               }
               else
               {
                  this.tokenizer.parseError("Expecting : but found " + this.token.value);
               }
            }
            else
            {
               this.tokenizer.parseError("Expecting string but found " + this.token.value);
            }
         }
         return null;
      }
      
      private function parseValue() : Object {
         if(this.token == null)
         {
            this.tokenizer.parseError("Unexpected end of input");
         }
         switch(this.token.type)
         {
            case JSONTokenType.LEFT_BRACE:
               return this.parseObject();
            case JSONTokenType.LEFT_BRACKET:
               return this.parseArray();
            case JSONTokenType.STRING:
            case JSONTokenType.NUMBER:
            case JSONTokenType.TRUE:
            case JSONTokenType.FALSE:
            case JSONTokenType.NULL:
               return this.token.value;
            case JSONTokenType.NAN:
               if(!this.strict)
               {
                  return this.token.value;
               }
               this.tokenizer.parseError("Unexpected " + this.token.value);
               this.tokenizer.parseError("Unexpected " + this.token.value);
               return null;
         }
      }
   }
}
