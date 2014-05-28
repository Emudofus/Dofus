package com.ankamagames.dofus.network.messages.game.actions.fight
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class GameActionFightCastRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function GameActionFightCastRequestMessage() {
         super();
      }
      
      public static const protocolId:uint = 1005;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var spellId:uint = 0;
      
      public var cellId:int = 0;
      
      override public function getMessageId() : uint {
         return 1005;
      }
      
      public function initGameActionFightCastRequestMessage(spellId:uint = 0, cellId:int = 0) : GameActionFightCastRequestMessage {
         this.spellId = spellId;
         this.cellId = cellId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.spellId = 0;
         this.cellId = 0;
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
         this.serializeAs_GameActionFightCastRequestMessage(output);
      }
      
      public function serializeAs_GameActionFightCastRequestMessage(output:IDataOutput) : void {
         if(this.spellId < 0)
         {
            throw new Error("Forbidden value (" + this.spellId + ") on element spellId.");
         }
         else
         {
            output.writeShort(this.spellId);
            if((this.cellId < -1) || (this.cellId > 559))
            {
               throw new Error("Forbidden value (" + this.cellId + ") on element cellId.");
            }
            else
            {
               output.writeShort(this.cellId);
               return;
            }
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GameActionFightCastRequestMessage(input);
      }
      
      public function deserializeAs_GameActionFightCastRequestMessage(input:IDataInput) : void {
         this.spellId = input.readShort();
         if(this.spellId < 0)
         {
            throw new Error("Forbidden value (" + this.spellId + ") on element of GameActionFightCastRequestMessage.spellId.");
         }
         else
         {
            this.cellId = input.readShort();
            if((this.cellId < -1) || (this.cellId > 559))
            {
               throw new Error("Forbidden value (" + this.cellId + ") on element of GameActionFightCastRequestMessage.cellId.");
            }
            else
            {
               return;
            }
         }
      }
   }
}
