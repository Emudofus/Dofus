package com.ankamagames.dofus.network.messages.game.actions.fight
{
   import com.ankamagames.dofus.network.messages.game.actions.AbstractGameActionMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class GameActionFightTriggerGlyphTrapMessage extends AbstractGameActionMessage implements INetworkMessage
   {
      
      public function GameActionFightTriggerGlyphTrapMessage() {
         super();
      }
      
      public static const protocolId:uint = 5741;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var markId:int = 0;
      
      public var triggeringCharacterId:int = 0;
      
      public var triggeredSpellId:uint = 0;
      
      override public function getMessageId() : uint {
         return 5741;
      }
      
      public function initGameActionFightTriggerGlyphTrapMessage(param1:uint=0, param2:int=0, param3:int=0, param4:int=0, param5:uint=0) : GameActionFightTriggerGlyphTrapMessage {
         super.initAbstractGameActionMessage(param1,param2);
         this.markId = param3;
         this.triggeringCharacterId = param4;
         this.triggeredSpellId = param5;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.markId = 0;
         this.triggeringCharacterId = 0;
         this.triggeredSpellId = 0;
         this._isInitialized = false;
      }
      
      override public function pack(param1:IDataOutput) : void {
         var _loc2_:ByteArray = new ByteArray();
         this.serialize(_loc2_);
         writePacket(param1,this.getMessageId(),_loc2_);
      }
      
      override public function unpack(param1:IDataInput, param2:uint) : void {
         this.deserialize(param1);
      }
      
      override public function serialize(param1:IDataOutput) : void {
         this.serializeAs_GameActionFightTriggerGlyphTrapMessage(param1);
      }
      
      public function serializeAs_GameActionFightTriggerGlyphTrapMessage(param1:IDataOutput) : void {
         super.serializeAs_AbstractGameActionMessage(param1);
         param1.writeShort(this.markId);
         param1.writeInt(this.triggeringCharacterId);
         if(this.triggeredSpellId < 0)
         {
            throw new Error("Forbidden value (" + this.triggeredSpellId + ") on element triggeredSpellId.");
         }
         else
         {
            param1.writeShort(this.triggeredSpellId);
            return;
         }
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_GameActionFightTriggerGlyphTrapMessage(param1);
      }
      
      public function deserializeAs_GameActionFightTriggerGlyphTrapMessage(param1:IDataInput) : void {
         super.deserialize(param1);
         this.markId = param1.readShort();
         this.triggeringCharacterId = param1.readInt();
         this.triggeredSpellId = param1.readShort();
         if(this.triggeredSpellId < 0)
         {
            throw new Error("Forbidden value (" + this.triggeredSpellId + ") on element of GameActionFightTriggerGlyphTrapMessage.triggeredSpellId.");
         }
         else
         {
            return;
         }
      }
   }
}
