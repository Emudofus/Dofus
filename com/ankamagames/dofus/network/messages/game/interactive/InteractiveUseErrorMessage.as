package com.ankamagames.dofus.network.messages.game.interactive
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class InteractiveUseErrorMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function InteractiveUseErrorMessage() {
         super();
      }
      
      public static const protocolId:uint = 6384;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var elemId:uint = 0;
      
      public var skillInstanceUid:uint = 0;
      
      override public function getMessageId() : uint {
         return 6384;
      }
      
      public function initInteractiveUseErrorMessage(elemId:uint=0, skillInstanceUid:uint=0) : InteractiveUseErrorMessage {
         this.elemId = elemId;
         this.skillInstanceUid = skillInstanceUid;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.elemId = 0;
         this.skillInstanceUid = 0;
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
         this.serializeAs_InteractiveUseErrorMessage(output);
      }
      
      public function serializeAs_InteractiveUseErrorMessage(output:IDataOutput) : void {
         if(this.elemId < 0)
         {
            throw new Error("Forbidden value (" + this.elemId + ") on element elemId.");
         }
         else
         {
            output.writeInt(this.elemId);
            if(this.skillInstanceUid < 0)
            {
               throw new Error("Forbidden value (" + this.skillInstanceUid + ") on element skillInstanceUid.");
            }
            else
            {
               output.writeInt(this.skillInstanceUid);
               return;
            }
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_InteractiveUseErrorMessage(input);
      }
      
      public function deserializeAs_InteractiveUseErrorMessage(input:IDataInput) : void {
         this.elemId = input.readInt();
         if(this.elemId < 0)
         {
            throw new Error("Forbidden value (" + this.elemId + ") on element of InteractiveUseErrorMessage.elemId.");
         }
         else
         {
            this.skillInstanceUid = input.readInt();
            if(this.skillInstanceUid < 0)
            {
               throw new Error("Forbidden value (" + this.skillInstanceUid + ") on element of InteractiveUseErrorMessage.skillInstanceUid.");
            }
            else
            {
               return;
            }
         }
      }
   }
}
