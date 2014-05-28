package com.ankamagames.dofus.network.messages.game.actions.fight
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class GameActionFightDispellSpellMessage extends GameActionFightDispellMessage implements INetworkMessage
   {
      
      public function GameActionFightDispellSpellMessage() {
         super();
      }
      
      public static const protocolId:uint = 6176;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var spellId:uint = 0;
      
      override public function getMessageId() : uint {
         return 6176;
      }
      
      public function initGameActionFightDispellSpellMessage(actionId:uint = 0, sourceId:int = 0, targetId:int = 0, spellId:uint = 0) : GameActionFightDispellSpellMessage {
         super.initGameActionFightDispellMessage(actionId,sourceId,targetId);
         this.spellId = spellId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.spellId = 0;
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
         this.serializeAs_GameActionFightDispellSpellMessage(output);
      }
      
      public function serializeAs_GameActionFightDispellSpellMessage(output:IDataOutput) : void {
         super.serializeAs_GameActionFightDispellMessage(output);
         if(this.spellId < 0)
         {
            throw new Error("Forbidden value (" + this.spellId + ") on element spellId.");
         }
         else
         {
            output.writeInt(this.spellId);
            return;
         }
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GameActionFightDispellSpellMessage(input);
      }
      
      public function deserializeAs_GameActionFightDispellSpellMessage(input:IDataInput) : void {
         super.deserialize(input);
         this.spellId = input.readInt();
         if(this.spellId < 0)
         {
            throw new Error("Forbidden value (" + this.spellId + ") on element of GameActionFightDispellSpellMessage.spellId.");
         }
         else
         {
            return;
         }
      }
   }
}
