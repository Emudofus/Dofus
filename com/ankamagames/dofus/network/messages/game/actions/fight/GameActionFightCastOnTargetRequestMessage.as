package com.ankamagames.dofus.network.messages.game.actions.fight
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class GameActionFightCastOnTargetRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function GameActionFightCastOnTargetRequestMessage() {
         super();
      }
      
      public static const protocolId:uint = 6330;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var spellId:uint = 0;
      
      public var targetId:int = 0;
      
      override public function getMessageId() : uint {
         return 6330;
      }
      
      public function initGameActionFightCastOnTargetRequestMessage(spellId:uint = 0, targetId:int = 0) : GameActionFightCastOnTargetRequestMessage {
         this.spellId = spellId;
         this.targetId = targetId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.spellId = 0;
         this.targetId = 0;
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
      
      public function serialize(output:IDataOutput) : void {
         this.serializeAs_GameActionFightCastOnTargetRequestMessage(output);
      }
      
      public function serializeAs_GameActionFightCastOnTargetRequestMessage(output:IDataOutput) : void {
         if(this.spellId < 0)
         {
            throw new Error("Forbidden value (" + this.spellId + ") on element spellId.");
         }
         else
         {
            output.writeShort(this.spellId);
            output.writeInt(this.targetId);
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GameActionFightCastOnTargetRequestMessage(input);
      }
      
      public function deserializeAs_GameActionFightCastOnTargetRequestMessage(input:IDataInput) : void {
         this.spellId = input.readShort();
         if(this.spellId < 0)
         {
            throw new Error("Forbidden value (" + this.spellId + ") on element of GameActionFightCastOnTargetRequestMessage.spellId.");
         }
         else
         {
            this.targetId = input.readInt();
            return;
         }
      }
   }
}
