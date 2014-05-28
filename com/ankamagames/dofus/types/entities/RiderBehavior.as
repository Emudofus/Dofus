package com.ankamagames.dofus.types.entities
{
   import com.ankamagames.tiphon.types.ISubEntityBehavior;
   import com.ankamagames.tiphon.display.TiphonSprite;
   import com.ankamagames.tiphon.types.BehaviorData;
   import com.ankamagames.tiphon.types.IAnimationModifier;
   import com.ankamagames.dofus.logic.game.fight.types.CastingSpell;
   import com.ankamagames.dofus.datacenter.effects.instances.EffectInstanceDice;
   import com.ankamagames.dofus.types.enums.AnimationEnum;
   import com.ankamagames.dofus.logic.game.fight.frames.FightSequenceFrame;
   import com.ankamagames.tiphon.engine.Tiphon;
   import com.ankamagames.tiphon.events.TiphonEvent;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayEntitiesFrame;
   import com.ankamagames.dofus.datacenter.communication.Emoticon;
   
   public class RiderBehavior extends Object implements ISubEntityBehavior
   {
      
      public function RiderBehavior() {
         super();
      }
      
      private var _subentity:TiphonSprite;
      
      private var _parentData:BehaviorData;
      
      private var _animation:String;
      
      private var _direction:int;
      
      public function updateFromParentEntity(target:TiphonSprite, parentData:BehaviorData) : void {
         var modifier:IAnimationModifier = null;
         var isAttack:* = false;
         var cs:CastingSpell = null;
         var effects:Vector.<EffectInstanceDice> = null;
         var effect:EffectInstanceDice = null;
         this._subentity = target;
         this._parentData = parentData;
         this._direction = this._parentData.direction;
         if((target.animationModifiers) && (target.animationModifiers.length))
         {
            for each(modifier in target.animationModifiers)
            {
               this._animation = modifier.getModifiedAnimation(parentData.animation,target.look);
            }
         }
         else
         {
            this._animation = parentData.animation;
         }
         switch(true)
         {
            case this._parentData.animation == AnimationEnum.ANIM_MARCHE:
            case this._parentData.animation == AnimationEnum.ANIM_COURSE:
               this._animation = AnimationEnum.ANIM_STATIQUE;
               break;
            case !(this._parentData.animation.indexOf("AnimEmoteRest") == -1):
            case !(this._parentData.animation.indexOf("AnimEmoteSit") == -1):
            case !(this._parentData.animation.indexOf("AnimEmoteRest") == -1):
            case !(this._parentData.animation.indexOf("AnimEmoteOups") == -1):
            case !(this._parentData.animation.indexOf("AnimEmoteShit") == -1):
               this._animation = AnimationEnum.ANIM_STATIQUE;
               break;
            case !(this._parentData.animation.indexOf("AnimArme") == -1):
               if(this._parentData.animation == "AnimArme0")
               {
                  this._animation = AnimationEnum.ANIM_STATIQUE;
               }
               else
               {
                  this._parentData.animation = AnimationEnum.ANIM_STATIQUE;
               }
               break;
            case !(this._parentData.animation.indexOf("AnimAttaque") == -1):
               this._parentData.animation = AnimationEnum.ANIM_STATIQUE;
               cs = FightSequenceFrame.lastCastingSpell;
               if(cs)
               {
                  effects = cs.spellRank.effects;
                  if(effects)
                  {
                     for each(effect in effects)
                     {
                        if(effect.category == 2)
                        {
                           isAttack = true;
                           break;
                        }
                     }
                  }
               }
               this._animation = "AnimAttaque" + (isAttack?1:0);
               break;
            case !(this._parentData.animation.indexOf("AnimCueillir") == -1):
            case !(this._parentData.animation.indexOf("AnimFaucher") == -1):
            case !(this._parentData.animation.indexOf("AnimPioche") == -1):
            case !(this._parentData.animation.indexOf("AnimHache") == -1):
            case !(this._parentData.animation.indexOf("AnimPeche") == -1):
            case !(this._parentData.animation.indexOf("AnimConsulter") == -1):
               this._parentData.animation = AnimationEnum.ANIM_STATIQUE;
               break;
         }
         if((!(this._parentData.animation.indexOf("AnimEmote") == -1)) && (!Tiphon.skullLibrary.hasAnim(this._parentData.parent.look.getBone(),this._parentData.animation)))
         {
            this._parentData.animation = AnimationEnum.ANIM_STATIQUE;
         }
         parentData.parent.addEventListener(TiphonEvent.RENDER_FATHER_SUCCEED,this.onFatherRendered);
      }
      
      public function remove() : void {
         if((this._parentData) && (this._parentData.parent))
         {
            this._parentData.parent.removeEventListener(TiphonEvent.RENDER_FATHER_SUCCEED,this.onFatherRendered);
         }
         this._parentData = null;
         this._subentity = null;
      }
      
      private function onFatherRendered(e:TiphonEvent) : void {
         var emoticonAnim:String = null;
         this._parentData.parent.removeEventListener(TiphonEvent.RENDER_FATHER_SUCCEED,this.onFatherRendered);
         var rpEntitiesFrame:RoleplayEntitiesFrame = Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame;
         var currentEmoticon:Emoticon = rpEntitiesFrame?Emoticon.getEmoticonById(rpEntitiesFrame.currentEmoticon):null;
         if((currentEmoticon) && (currentEmoticon.persistancy) && (this._parentData.animation == AnimationEnum.ANIM_STATIQUE))
         {
            emoticonAnim = currentEmoticon.getAnimName(this._subentity.look);
            if(this._subentity.getAnimation() == emoticonAnim.replace("_","_Statique_"))
            {
               this._animation = this._subentity.getAnimation();
            }
         }
         this._subentity.setAnimationAndDirection(this._animation,this._direction);
      }
   }
}
