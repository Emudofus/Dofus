package com.ankamagames.dofus.types.characteristicContextual
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   
   public class StyledTextContextual extends CharacteristicContextual
   {
      
      public function StyledTextContextual(param1:String, param2:uint) {
         super();
         this.init(param1,param2);
      }
      
      private static const STYLE_0_NUMBER_0:Class = StyledTextContextual_STYLE_0_NUMBER_0;
      
      private static const STYLE_0_NUMBER_1:Class = StyledTextContextual_STYLE_0_NUMBER_1;
      
      private static const STYLE_0_NUMBER_2:Class = StyledTextContextual_STYLE_0_NUMBER_2;
      
      private static const STYLE_0_NUMBER_3:Class = StyledTextContextual_STYLE_0_NUMBER_3;
      
      private static const STYLE_0_NUMBER_4:Class = StyledTextContextual_STYLE_0_NUMBER_4;
      
      private static const STYLE_0_NUMBER_5:Class = StyledTextContextual_STYLE_0_NUMBER_5;
      
      private static const STYLE_0_NUMBER_6:Class = StyledTextContextual_STYLE_0_NUMBER_6;
      
      private static const STYLE_0_NUMBER_7:Class = StyledTextContextual_STYLE_0_NUMBER_7;
      
      private static const STYLE_0_NUMBER_8:Class = StyledTextContextual_STYLE_0_NUMBER_8;
      
      private static const STYLE_0_NUMBER_9:Class = StyledTextContextual_STYLE_0_NUMBER_9;
      
      private static const STYLE_0_NUMBER_MOINS:Class = StyledTextContextual_STYLE_0_NUMBER_MOINS;
      
      private static const STYLE_0_NUMBER_PLUS:Class = StyledTextContextual_STYLE_0_NUMBER_PLUS;
      
      private static const STYLE_1_NUMBER_0:Class = StyledTextContextual_STYLE_1_NUMBER_0;
      
      private static const STYLE_1_NUMBER_1:Class = StyledTextContextual_STYLE_1_NUMBER_1;
      
      private static const STYLE_1_NUMBER_2:Class = StyledTextContextual_STYLE_1_NUMBER_2;
      
      private static const STYLE_1_NUMBER_3:Class = StyledTextContextual_STYLE_1_NUMBER_3;
      
      private static const STYLE_1_NUMBER_4:Class = StyledTextContextual_STYLE_1_NUMBER_4;
      
      private static const STYLE_1_NUMBER_5:Class = StyledTextContextual_STYLE_1_NUMBER_5;
      
      private static const STYLE_1_NUMBER_6:Class = StyledTextContextual_STYLE_1_NUMBER_6;
      
      private static const STYLE_1_NUMBER_7:Class = StyledTextContextual_STYLE_1_NUMBER_7;
      
      private static const STYLE_1_NUMBER_8:Class = StyledTextContextual_STYLE_1_NUMBER_8;
      
      private static const STYLE_1_NUMBER_9:Class = StyledTextContextual_STYLE_1_NUMBER_9;
      
      private static const STYLE_1_NUMBER_MOINS:Class = StyledTextContextual_STYLE_1_NUMBER_MOINS;
      
      private static const STYLE_1_NUMBER_PLUS:Class = StyledTextContextual_STYLE_1_NUMBER_PLUS;
      
      private static const STYLE_2_NUMBER_0:Class = StyledTextContextual_STYLE_2_NUMBER_0;
      
      private static const STYLE_2_NUMBER_1:Class = StyledTextContextual_STYLE_2_NUMBER_1;
      
      private static const STYLE_2_NUMBER_2:Class = StyledTextContextual_STYLE_2_NUMBER_2;
      
      private static const STYLE_2_NUMBER_3:Class = StyledTextContextual_STYLE_2_NUMBER_3;
      
      private static const STYLE_2_NUMBER_4:Class = StyledTextContextual_STYLE_2_NUMBER_4;
      
      private static const STYLE_2_NUMBER_5:Class = StyledTextContextual_STYLE_2_NUMBER_5;
      
      private static const STYLE_2_NUMBER_6:Class = StyledTextContextual_STYLE_2_NUMBER_6;
      
      private static const STYLE_2_NUMBER_7:Class = StyledTextContextual_STYLE_2_NUMBER_7;
      
      private static const STYLE_2_NUMBER_8:Class = StyledTextContextual_STYLE_2_NUMBER_8;
      
      private static const STYLE_2_NUMBER_9:Class = StyledTextContextual_STYLE_2_NUMBER_9;
      
      private static const STYLE_2_NUMBER_MOINS:Class = StyledTextContextual_STYLE_2_NUMBER_MOINS;
      
      private static const STYLE_2_NUMBER_PLUS:Class = StyledTextContextual_STYLE_2_NUMBER_PLUS;
      
      private static const STYLE_3_NUMBER_0:Class = StyledTextContextual_STYLE_3_NUMBER_0;
      
      private static const STYLE_3_NUMBER_1:Class = StyledTextContextual_STYLE_3_NUMBER_1;
      
      private static const STYLE_3_NUMBER_2:Class = StyledTextContextual_STYLE_3_NUMBER_2;
      
      private static const STYLE_3_NUMBER_3:Class = StyledTextContextual_STYLE_3_NUMBER_3;
      
      private static const STYLE_3_NUMBER_4:Class = StyledTextContextual_STYLE_3_NUMBER_4;
      
      private static const STYLE_3_NUMBER_5:Class = StyledTextContextual_STYLE_3_NUMBER_5;
      
      private static const STYLE_3_NUMBER_6:Class = StyledTextContextual_STYLE_3_NUMBER_6;
      
      private static const STYLE_3_NUMBER_7:Class = StyledTextContextual_STYLE_3_NUMBER_7;
      
      private static const STYLE_3_NUMBER_8:Class = StyledTextContextual_STYLE_3_NUMBER_8;
      
      private static const STYLE_3_NUMBER_9:Class = StyledTextContextual_STYLE_3_NUMBER_9;
      
      private static const STYLE_3_NUMBER_MOINS:Class = StyledTextContextual_STYLE_3_NUMBER_MOINS;
      
      private static const STYLE_3_NUMBER_PLUS:Class = StyledTextContextual_STYLE_3_NUMBER_PLUS;
      
      private function init(param1:String, param2:uint) : void {
         var _loc3_:DisplayObject = null;
         var _loc5_:String = null;
         var _loc6_:Sprite = null;
         var _loc4_:uint = 0;
         while(_loc4_ < param1.length)
         {
            _loc5_ = param1.charAt(_loc4_);
            switch(_loc5_)
            {
               case "-":
                  _loc5_ = "MOINS";
                  break;
               case "+":
                  _loc5_ = "PLUS";
                  break;
            }
            _loc6_ = new StyledTextContextual["STYLE_" + param2 + "_NUMBER_" + _loc5_]() as Sprite;
            _loc6_.scaleX = 0.7;
            _loc6_.scaleY = 0.7;
            if(_loc3_)
            {
               _loc6_.x = _loc3_.x + _loc3_.width + 5;
            }
            addChild(_loc6_);
            _loc3_ = _loc6_;
            _loc4_++;
         }
         mouseEnabled = false;
         mouseChildren = false;
         cacheAsBitmap = true;
      }
   }
}
