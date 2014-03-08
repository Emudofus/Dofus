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
      
      public function initGameActionFightTriggerGlyphTrapMessage(actionId:uint=0, sourceId:int=0, markId:int=0, triggeringCharacterId:int=0, triggeredSpellId:uint=0) : GameActionFightTriggerGlyphTrapMessage {
         super.initAbstractGameActionMessage(actionId,sourceId);
         this.markId = markId;
         this.triggeringCharacterId = triggeringCharacterId;
         this.triggeredSpellId = triggeredSpellId;
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
      
      override public function pack(output:IDataOutput) : void {
         var data:ByteArray = new ByteArray();
         this.serialize(data);
         writePacket(output,this.getMessageId(),data);
      }
      
      override public function unpack(input:IDataInput, length:uint) : void {
         this.deserialize(input);
      }
      
      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_GameActionFightTriggerGlyphTrapMessage(output);
      }
      
      public function serializeAs_GameActionFightTriggerGlyphTrapMessage(output:IDataOutput) : void {
         super.serializeAs_AbstractGameActionMessage(output);
         output.writeShort(this.markId);
         output.writeInt(this.triggeringCharacterId);
         if(this.triggeredSpellId < 0)
         {
            throw new Error("Forbidden value (" + this.triggeredSpellId + ") on element triggeredSpellId.");
         }
         else
         {
            output.writeShort(this.triggeredSpellId);
            return;
         }
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GameActionFightTriggerGlyphTrapMessage(input);
      }
      
      public function deserializeAs_GameActionFightTriggerGlyphTrapMessage(input:IDataInput) : void {
         super.deserialize(input);
         this.markId = input.readShort();
         this.triggeringCharacterId = input.readInt();
         this.triggeredSpellId = input.readShort();
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
