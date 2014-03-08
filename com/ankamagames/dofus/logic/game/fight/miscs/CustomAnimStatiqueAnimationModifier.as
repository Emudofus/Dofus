package com.ankamagames.dofus.logic.game.fight.miscs
{
   import com.ankamagames.tiphon.types.IAnimationModifier;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.tiphon.types.AnimationModifierPriority;
   import com.ankamagames.tiphon.types.look.TiphonEntityLook;
   import com.ankamagames.jerakine.types.Swl;
   import com.ankamagames.tiphon.engine.Tiphon;
   import com.ankamagames.dofus.types.enums.AnimationEnum;
   
   public class CustomAnimStatiqueAnimationModifier extends Object implements IAnimationModifier
   {
      
      public function CustomAnimStatiqueAnimationModifier() {
         super();
      }
      
      private static const _log:Logger = Log.getLogger(getQualifiedClassName(CustomAnimStatiqueAnimationModifier));
      
      public var randomStatique:Boolean;
      
      public function get priority() : int {
         return AnimationModifierPriority.NORMAL;
      }
      
      public function getModifiedAnimation(param1:String, param2:TiphonEntityLook) : String {
         var _loc3_:Swl = null;
         var _loc4_:Array = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc7_:* = 0;
         var _loc8_:* = 0;
         var _loc9_:String = null;
         switch(param1)
         {
            case AnimationEnum.ANIM_STATIQUE:
               if(param2.getBone() == 1)
               {
                  if(this.randomStatique)
                  {
                     _loc3_ = Tiphon.skullLibrary.getResourceById(param2.getBone(),AnimationEnum.ANIM_STATIQUE);
                     _loc4_ = new Array();
                     if(_loc3_)
                     {
                        for each (_loc5_ in _loc3_.getDefinitions())
                        {
                           if(_loc5_.indexOf(AnimationEnum.ANIM_STATIQUE + param2.firstSkin.toString()) == 0)
                           {
                              _loc6_ = _loc5_.split("_")[0];
                              if(_loc4_.indexOf(_loc6_) == -1)
                              {
                                 _loc4_.push(_loc6_);
                              }
                           }
                        }
                     }
                     else
                     {
                        _loc4_.push(AnimationEnum.ANIM_STATIQUE + param2.firstSkin.toString());
                     }
                     if(_loc4_.length > 1)
                     {
                        _loc7_ = Math.floor(Math.random() * _loc4_.length);
                        return _loc4_[_loc7_];
                     }
                     return _loc4_[0];
                  }
                  _loc8_ = param2.firstSkin;
                  if(_loc8_ == 1114 || _loc8_ == 1115 || _loc8_ == 1402 || _loc8_ == 1463 || _loc8_ == param2.defaultSkin)
                  {
                     return AnimationEnum.ANIM_STATIQUE;
                  }
                  return AnimationEnum.ANIM_STATIQUE + param2.firstSkin.toString();
               }
               return param1;
            case AnimationEnum.ANIM_MORT:
               if(param2.getBone() == 1)
               {
                  _loc9_ = AnimationEnum.ANIM_MORT + param2.firstSkin.toString();
                  _loc3_ = Tiphon.skullLibrary.getResourceById(param2.getBone(),_loc9_);
                  if(_loc3_)
                  {
                     return _loc9_;
                  }
               }
               return param1;
            default:
               return param1;
         }
      }
   }
}
