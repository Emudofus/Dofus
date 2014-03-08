package com.ankamagames.tiphon.types
{
   import com.ankamagames.tiphon.types.look.TiphonEntityLook;
   import flash.display.DisplayObjectContainer;
   import com.ankamagames.tiphon.display.TiphonSprite;
   
   public class TiphonUtility extends Object
   {
      
      public function TiphonUtility() {
         super();
      }
      
      public static function getLookWithoutMount(param1:TiphonEntityLook) : TiphonEntityLook {
         var _loc3_:* = 0;
         var _loc2_:TiphonEntityLook = param1.getSubEntity(2,0);
         if(_loc2_)
         {
            _loc3_ = _loc2_.getBone();
            if(_loc3_ == 1084)
            {
               _loc2_.setBone(44);
            }
            else
            {
               if(_loc3_ == 1068)
               {
                  _loc2_.setBone(113);
               }
               else
               {
                  if(_loc3_ == 1202)
                  {
                     _loc2_.setBone(453);
                  }
                  else
                  {
                     if(_loc3_ == 1575 || _loc3_ == 1576 || _loc3_ == 2)
                     {
                        _loc2_.setBone(1);
                     }
                     else
                     {
                        if(_loc3_ == 2456)
                        {
                           _loc2_.setBone(1107);
                        }
                     }
                  }
               }
            }
            return _loc2_;
         }
         return param1;
      }
      
      public static function getEntityWithoutMount(param1:TiphonSprite) : DisplayObjectContainer {
         if(param1 == null)
         {
            return null;
         }
         var _loc2_:DisplayObjectContainer = param1.getSubEntitySlot(2,0);
         return _loc2_ == null?param1:_loc2_;
      }
      
      public static function getFlipDirection(param1:int) : uint {
         if(param1 == 0)
         {
            return 4;
         }
         if(param1 == 1)
         {
            return 3;
         }
         if(param1 == 7)
         {
            return 5;
         }
         if(param1 == 4)
         {
            return 0;
         }
         if(param1 == 3)
         {
            return 1;
         }
         if(param1 == 5)
         {
            return 7;
         }
         return param1;
      }
   }
}
