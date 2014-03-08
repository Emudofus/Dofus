package com.ankamagames.tiphon.types.cache
{
   import __AS3__.vec.Vector;
   import com.ankamagames.tiphon.types.ScriptedAnimation;
   
   public class AnimCache extends Object
   {
      
      public function AnimCache() {
         this._directions = new Vector.<Vector.<ScriptedAnimation>>(8,true);
         super();
         this._directions[0] = new Vector.<ScriptedAnimation>();
         this._directions[1] = new Vector.<ScriptedAnimation>();
         this._directions[2] = new Vector.<ScriptedAnimation>();
         this._directions[6] = new Vector.<ScriptedAnimation>();
         this._directions[7] = new Vector.<ScriptedAnimation>();
      }
      
      private var _directions:Vector.<Vector.<ScriptedAnimation>>;
      
      public function getAnimation(param1:int) : ScriptedAnimation {
         var _loc2_:* = 0;
         if(param1 == 3)
         {
            _loc2_ = 1;
         }
         else
         {
            if(param1 == 4)
            {
               _loc2_ = 0;
            }
            else
            {
               if(param1 == 5)
               {
                  _loc2_ = 7;
               }
               else
               {
                  _loc2_ = param1;
               }
            }
         }
         var _loc3_:Vector.<ScriptedAnimation> = this._directions[_loc2_];
         if(_loc3_.length)
         {
            return _loc3_.shift();
         }
         return null;
      }
      
      public function pushAnimation(param1:ScriptedAnimation, param2:int) : void {
         var _loc3_:* = 0;
         if(param2 == 3)
         {
            _loc3_ = 1;
         }
         else
         {
            if(param2 == 4)
            {
               _loc3_ = 0;
            }
            else
            {
               if(param2 == 5)
               {
                  _loc3_ = 7;
               }
               else
               {
                  _loc3_ = param2;
               }
            }
         }
         this._directions[_loc3_].push(param1);
      }
   }
}
