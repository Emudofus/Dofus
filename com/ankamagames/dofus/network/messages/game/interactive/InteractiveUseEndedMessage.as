package com.ankamagames.dofus.network.messages.game.interactive
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class InteractiveUseEndedMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function InteractiveUseEndedMessage() {
         super();
      }
      
      public static const protocolId:uint = 6112;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var elemId:uint = 0;
      
      public var skillId:uint = 0;
      
      override public function getMessageId() : uint {
         return 6112;
      }
      
      public function initInteractiveUseEndedMessage(elemId:uint=0, skillId:uint=0) : InteractiveUseEndedMessage {
         this.elemId = elemId;
         this.skillId = skillId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.elemId = 0;
         this.skillId = 0;
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
         this.serializeAs_InteractiveUseEndedMessage(output);
      }
      
      public function serializeAs_InteractiveUseEndedMessage(output:IDataOutput) : void {
         if(this.elemId < 0)
         {
            throw new Error("Forbidden value (" + this.elemId + ") on element elemId.");
         }
         else
         {
            output.writeInt(this.elemId);
            if(this.skillId < 0)
            {
               throw new Error("Forbidden value (" + this.skillId + ") on element skillId.");
            }
            else
            {
               output.writeShort(this.skillId);
               return;
            }
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_InteractiveUseEndedMessage(input);
      }
      
      public function deserializeAs_InteractiveUseEndedMessage(input:IDataInput) : void {
         this.elemId = input.readInt();
         if(this.elemId < 0)
         {
            throw new Error("Forbidden value (" + this.elemId + ") on element of InteractiveUseEndedMessage.elemId.");
         }
         else
         {
            this.skillId = input.readShort();
            if(this.skillId < 0)
            {
               throw new Error("Forbidden value (" + this.skillId + ") on element of InteractiveUseEndedMessage.skillId.");
            }
            else
            {
               return;
            }
         }
      }
   }
}
