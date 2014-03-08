package com.ankamagames.dofus.network.types.game.actions.fight
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class FightTriggeredEffect extends AbstractFightDispellableEffect implements INetworkType
   {
      
      public function FightTriggeredEffect() {
         super();
      }
      
      public static const protocolId:uint = 210;
      
      public var param1:int = 0;
      
      public var param2:int = 0;
      
      public var param3:int = 0;
      
      public var delay:int = 0;
      
      override public function getTypeId() : uint {
         return 210;
      }
      
      public function initFightTriggeredEffect(uid:uint=0, targetId:int=0, turnDuration:int=0, dispelable:uint=1, spellId:uint=0, parentBoostUid:uint=0, param1:int=0, param2:int=0, param3:int=0, delay:int=0) : FightTriggeredEffect {
         super.initAbstractFightDispellableEffect(uid,targetId,turnDuration,dispelable,spellId,parentBoostUid);
         this.param1 = param1;
         this.param2 = param2;
         this.param3 = param3;
         this.delay = delay;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.param1 = 0;
         this.param2 = 0;
         this.param3 = 0;
         this.delay = 0;
      }
      
      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_FightTriggeredEffect(output);
      }
      
      public function serializeAs_FightTriggeredEffect(output:IDataOutput) : void {
         super.serializeAs_AbstractFightDispellableEffect(output);
         output.writeInt(this.param1);
         output.writeInt(this.param2);
         output.writeInt(this.param3);
         output.writeShort(this.delay);
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_FightTriggeredEffect(input);
      }
      
      public function deserializeAs_FightTriggeredEffect(input:IDataInput) : void {
         super.deserialize(input);
         this.param1 = input.readInt();
         this.param2 = input.readInt();
         this.param3 = input.readInt();
         this.delay = input.readShort();
      }
   }
}
