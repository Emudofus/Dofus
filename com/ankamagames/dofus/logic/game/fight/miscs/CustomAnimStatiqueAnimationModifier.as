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
      
      private static const _log:Logger;
      
      public var randomStatique:Boolean;
      
      public function get priority() : int {
         return AnimationModifierPriority.NORMAL;
      }
      
      public function getModifiedAnimation(pAnimation:String, pLook:TiphonEntityLook) : String {
         var lib:Swl = null;
         var statics:Array = null;
         var anim:String = null;
         var animName:String = null;
         var random:* = 0;
         var skinId:* = 0;
         var animDeathName:String = null;
         switch(pAnimation)
         {
            case AnimationEnum.ANIM_STATIQUE:
               if(pLook.getBone() == 1)
               {
                  if(this.randomStatique)
                  {
                     lib = Tiphon.skullLibrary.getResourceById(pLook.getBone(),AnimationEnum.ANIM_STATIQUE);
                     statics = new Array();
                     if(lib)
                     {
                        for each(anim in lib.getDefinitions())
                        {
                           if(anim.indexOf(AnimationEnum.ANIM_STATIQUE + pLook.firstSkin.toString()) == 0)
                           {
                              animName = anim.split("_")[0];
                              if(statics.indexOf(animName) == -1)
                              {
                                 statics.push(animName);
                              }
                           }
                        }
                     }
                     else
                     {
                        statics.push(AnimationEnum.ANIM_STATIQUE + pLook.firstSkin.toString());
                     }
                     if(statics.length > 1)
                     {
                        random = Math.floor(Math.random() * statics.length);
                        return statics[random];
                     }
                     return statics[0];
                  }
                  skinId = pLook.firstSkin;
                  if((skinId == 1114) || (skinId == 1115) || (skinId == 1402) || (skinId == 1463) || (skinId == pLook.defaultSkin))
                  {
                     return AnimationEnum.ANIM_STATIQUE;
                  }
                  return AnimationEnum.ANIM_STATIQUE + pLook.firstSkin.toString();
               }
               return pAnimation;
            case AnimationEnum.ANIM_MORT:
               if(pLook.getBone() == 1)
               {
                  animDeathName = AnimationEnum.ANIM_MORT + pLook.firstSkin.toString();
                  lib = Tiphon.skullLibrary.getResourceById(pLook.getBone(),animDeathName);
                  if(lib)
                  {
                     return animDeathName;
                  }
               }
               return pAnimation;
            default:
               return pAnimation;
         }
      }
   }
}
