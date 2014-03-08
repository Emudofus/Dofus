package com.ankamagames.dofus.scripts
{
   import com.ankamagames.jerakine.lua.LuaPackage;
   import com.ankamagames.tiphon.display.TiphonSprite;
   import com.ankamagames.dofus.types.entities.AnimatedCharacter;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import com.ankamagames.tiphon.types.look.EntityLookParser;
   import com.ankamagames.jerakine.sequencer.ISequencable;
   import com.ankamagames.dofus.logic.game.common.steps.MoveStep;
   import com.ankamagames.atouin.entities.behaviours.movements.WalkingMovementBehavior;
   import com.ankamagames.atouin.entities.behaviours.movements.RunningMovementBehavior;
   import com.ankamagames.atouin.entities.behaviours.movements.SlideMovementBehavior;
   import com.ankamagames.dofus.logic.game.common.steps.TeleportStep;
   import com.ankamagames.dofus.logic.game.common.steps.LookAtStep;
   import com.ankamagames.dofus.logic.game.common.steps.WaitStep;
   import com.ankamagames.jerakine.sequencer.CallbackStep;
   import com.ankamagames.jerakine.types.Callback;
   import com.ankamagames.tiphon.sequence.SetDirectionStep;
   import com.ankamagames.tiphon.sequence.PlayAnimationStep;
   import com.ankamagames.dofus.logic.game.common.steps.PlayEmoteStep;
   import com.ankamagames.dofus.logic.game.common.steps.PlaySmileyStep;
   import com.ankamagames.dofus.logic.game.common.steps.TextBubbleStep;
   import com.ankamagames.dofus.internalDatacenter.communication.ThinkBubble;
   import com.ankamagames.dofus.internalDatacenter.communication.ChatBubble;
   import com.ankamagames.dofus.logic.game.common.steps.DisplayEntityStep;
   import com.ankamagames.dofus.logic.game.common.steps.RemoveEntityStep;
   import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
   
   public class ScriptEntity extends Object implements LuaPackage
   {
      
      public function ScriptEntity(param1:int, param2:String, param3:TiphonSprite=null) {
         super();
         this._id = param1;
         this._look = param2;
         this._entity = param3;
      }
      
      private var _id:int;
      
      private var _look:String;
      
      private var _entity:TiphonSprite;
      
      private var _direction:int = 1;
      
      private var _x:int;
      
      private var _y:int;
      
      private var _scaleX:Number;
      
      private var _scaleY:Number;
      
      public function get x() : int {
         if(this.getEntitySprite())
         {
            this._x = AnimatedCharacter(this._entity).position.x;
         }
         return this._x;
      }
      
      public function get y() : int {
         if(this.getEntitySprite())
         {
            this._y = AnimatedCharacter(this._entity).position.y;
         }
         return this._y;
      }
      
      public function set x(param1:int) : void {
         this._x = param1;
         if(this.getEntitySprite())
         {
            this.teleport(this._x,this._y).start();
         }
      }
      
      public function set y(param1:int) : void {
         this._y = param1;
         if(this.getEntitySprite())
         {
            this.teleport(this._x,this._y).start();
         }
      }
      
      public function get cellId() : uint {
         return MapPoint.fromCoords(this._x,this._y).cellId;
      }
      
      public function set cellId(param1:uint) : void {
         if(this.getEntitySprite())
         {
            this.teleport(param1).start();
         }
      }
      
      public function get id() : int {
         return this._id;
      }
      
      public function get look() : String {
         return this._look;
      }
      
      public function set look(param1:String) : void {
         if(this.getEntitySprite())
         {
            this._look = param1;
            this._entity.look.updateFrom(EntityLookParser.fromString(param1));
         }
      }
      
      public function get direction() : int {
         return this._direction;
      }
      
      public function set direction(param1:int) : void {
         this._direction = param1;
         if(this.getEntitySprite())
         {
            this._entity.setDirection(param1);
         }
      }
      
      public function get scaleX() : Number {
         return this.getEntitySprite()?this._entity.scaleX:NaN;
      }
      
      public function set scaleX(param1:Number) : void {
         if(this.getEntitySprite())
         {
            this._entity.scaleX = param1;
         }
      }
      
      public function get scaleY() : Number {
         return this.getEntitySprite()?this._entity.scaleY:NaN;
      }
      
      public function set scaleY(param1:Number) : void {
         if(this.getEntitySprite())
         {
            this._entity.scaleY = param1;
         }
      }
      
      public function move(... rest) : ISequencable {
         var _loc2_:ISequencable = null;
         if(this.getEntitySprite())
         {
            _loc2_ = new MoveStep(AnimatedCharacter(this._entity),rest);
         }
         return _loc2_;
      }
      
      public function walk(... rest) : ISequencable {
         var _loc2_:ISequencable = null;
         if(this.getEntitySprite())
         {
            _loc2_ = new MoveStep(AnimatedCharacter(this._entity),rest,WalkingMovementBehavior.getInstance());
         }
         return _loc2_;
      }
      
      public function run(... rest) : ISequencable {
         var _loc2_:ISequencable = null;
         if(this.getEntitySprite())
         {
            _loc2_ = new MoveStep(AnimatedCharacter(this._entity),rest,RunningMovementBehavior.getInstance());
         }
         return _loc2_;
      }
      
      public function slide(... rest) : ISequencable {
         var _loc2_:ISequencable = null;
         if(this.getEntitySprite())
         {
            _loc2_ = new MoveStep(AnimatedCharacter(this._entity),rest,SlideMovementBehavior.getInstance());
         }
         return _loc2_;
      }
      
      public function teleport(... rest) : ISequencable {
         var _loc2_:ISequencable = null;
         if(this.getEntitySprite())
         {
            _loc2_ = new TeleportStep(AnimatedCharacter(this._entity),rest);
         }
         return _loc2_;
      }
      
      public function lookAt(... rest) : ISequencable {
         var _loc2_:ISequencable = null;
         if(this.getEntitySprite())
         {
            _loc2_ = new LookAtStep(AnimatedCharacter(this._entity),rest);
         }
         return _loc2_;
      }
      
      public function wait(param1:int) : ISequencable {
         return new WaitStep(param1);
      }
      
      public function stop() : ISequencable {
         var _loc1_:ISequencable = null;
         if(this.getEntitySprite())
         {
            _loc1_ = new CallbackStep(new Callback(AnimatedCharacter(this._entity).stop));
         }
         return _loc1_;
      }
      
      public function setDirection(param1:int) : ISequencable {
         var _loc2_:ISequencable = null;
         if(this.getEntitySprite())
         {
            _loc2_ = new SetDirectionStep(this._entity,param1);
         }
         return _loc2_;
      }
      
      public function setAnimation(param1:String, param2:int=1, param3:String="") : ISequencable {
         var _loc4_:ISequencable = null;
         if(this.getEntitySprite())
         {
            _loc4_ = new PlayAnimationStep(this._entity,param1,true,true,"animation_event_end",param2,param3);
         }
         return _loc4_;
      }
      
      public function playEmote(param1:int, param2:Boolean=true) : ISequencable {
         var _loc3_:ISequencable = null;
         if(this.getEntitySprite())
         {
            _loc3_ = new PlayEmoteStep(this._entity as AnimatedCharacter,param1,param2);
         }
         return _loc3_;
      }
      
      public function playSmiley(param1:int, param2:Boolean=true) : ISequencable {
         var _loc3_:ISequencable = null;
         if(this.getEntitySprite())
         {
            _loc3_ = new PlaySmileyStep(this._entity as AnimatedCharacter,param1,param2);
         }
         return _loc3_;
      }
      
      public function think(param1:String, param2:Boolean=true) : ISequencable {
         var _loc3_:ISequencable = null;
         if(this.getEntitySprite())
         {
            _loc3_ = new TextBubbleStep(this._entity as AnimatedCharacter,new ThinkBubble(param1),param2);
         }
         return _loc3_;
      }
      
      public function speak(param1:String, param2:Boolean=true) : ISequencable {
         var _loc3_:ISequencable = null;
         if(this.getEntitySprite())
         {
            _loc3_ = new TextBubbleStep(this._entity as AnimatedCharacter,new ChatBubble(param1),param2);
         }
         return _loc3_;
      }
      
      public function setLook(param1:String) : ISequencable {
         var _loc2_:ISequencable = null;
         if(this.getEntitySprite())
         {
            _loc2_ = CallbackStep(new Callback(this._entity.look.updateFrom,EntityLookParser.fromString(param1)));
         }
         return _loc2_;
      }
      
      public function display() : ISequencable {
         return new DisplayEntityStep(this._id,this._look,MapPoint.fromCoords(this._x,this._y).cellId,this._direction);
      }
      
      public function remove() : ISequencable {
         return new RemoveEntityStep(this._id);
      }
      
      public function destroy() : void {
      }
      
      private function getEntitySprite() : TiphonSprite {
         if(!this._entity)
         {
            this._entity = DofusEntities.getEntity(this._id) as TiphonSprite;
         }
         return this._entity;
      }
   }
}
