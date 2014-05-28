package com.ankamagames.dofus.types.characteristicContextual
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   
   public class StyledTextContextual extends CharacteristicContextual
   {
      
      public function StyledTextContextual(value:String, style:uint) {
         super();
         this.init(value,style);
      }
      
      private static const STYLE_0_NUMBER_0:Class;
      
      private static const STYLE_0_NUMBER_1:Class;
      
      private static const STYLE_0_NUMBER_2:Class;
      
      private static const STYLE_0_NUMBER_3:Class;
      
      private static const STYLE_0_NUMBER_4:Class;
      
      private static const STYLE_0_NUMBER_5:Class;
      
      private static const STYLE_0_NUMBER_6:Class;
      
      private static const STYLE_0_NUMBER_7:Class;
      
      private static const STYLE_0_NUMBER_8:Class;
      
      private static const STYLE_0_NUMBER_9:Class;
      
      private static const STYLE_0_NUMBER_MOINS:Class;
      
      private static const STYLE_0_NUMBER_PLUS:Class;
      
      private static const STYLE_1_NUMBER_0:Class;
      
      private static const STYLE_1_NUMBER_1:Class;
      
      private static const STYLE_1_NUMBER_2:Class;
      
      private static const STYLE_1_NUMBER_3:Class;
      
      private static const STYLE_1_NUMBER_4:Class;
      
      private static const STYLE_1_NUMBER_5:Class;
      
      private static const STYLE_1_NUMBER_6:Class;
      
      private static const STYLE_1_NUMBER_7:Class;
      
      private static const STYLE_1_NUMBER_8:Class;
      
      private static const STYLE_1_NUMBER_9:Class;
      
      private static const STYLE_1_NUMBER_MOINS:Class;
      
      private static const STYLE_1_NUMBER_PLUS:Class;
      
      private static const STYLE_2_NUMBER_0:Class;
      
      private static const STYLE_2_NUMBER_1:Class;
      
      private static const STYLE_2_NUMBER_2:Class;
      
      private static const STYLE_2_NUMBER_3:Class;
      
      private static const STYLE_2_NUMBER_4:Class;
      
      private static const STYLE_2_NUMBER_5:Class;
      
      private static const STYLE_2_NUMBER_6:Class;
      
      private static const STYLE_2_NUMBER_7:Class;
      
      private static const STYLE_2_NUMBER_8:Class;
      
      private static const STYLE_2_NUMBER_9:Class;
      
      private static const STYLE_2_NUMBER_MOINS:Class;
      
      private static const STYLE_2_NUMBER_PLUS:Class;
      
      private static const STYLE_3_NUMBER_0:Class;
      
      private static const STYLE_3_NUMBER_1:Class;
      
      private static const STYLE_3_NUMBER_2:Class;
      
      private static const STYLE_3_NUMBER_3:Class;
      
      private static const STYLE_3_NUMBER_4:Class;
      
      private static const STYLE_3_NUMBER_5:Class;
      
      private static const STYLE_3_NUMBER_6:Class;
      
      private static const STYLE_3_NUMBER_7:Class;
      
      private static const STYLE_3_NUMBER_8:Class;
      
      private static const STYLE_3_NUMBER_9:Class;
      
      private static const STYLE_3_NUMBER_MOINS:Class;
      
      private static const STYLE_3_NUMBER_PLUS:Class;
      
      private function init(value:String, style:uint) : void {
         var last:DisplayObject = null;
         var char:String = null;
         var n:Sprite = null;
         var i:uint = 0;
         while(i < value.length)
         {
            char = value.charAt(i);
            switch(char)
            {
               case "-":
                  char = "MOINS";
                  break;
               case "+":
                  char = "PLUS";
                  break;
            }
            n = new StyledTextContextual["STYLE_" + style + "_NUMBER_" + char]() as Sprite;
            n.scaleX = 0.7;
            n.scaleY = 0.7;
            if(last)
            {
               n.x = last.x + last.width + 5;
            }
            addChild(n);
            last = n;
            i++;
         }
         mouseEnabled = false;
         mouseChildren = false;
         cacheAsBitmap = true;
      }
   }
}
