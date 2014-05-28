package com.ankamagames.dofus.network.messages.game.context.roleplay.treasureHunt
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class PortalDialogQuestionMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function PortalDialogQuestionMessage() {
         super();
      }
      
      public static const protocolId:uint = 6495;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var availableUseLeft:uint = 0;
      
      public var closeDate:uint = 0;
      
      override public function getMessageId() : uint {
         return 6495;
      }
      
      public function initPortalDialogQuestionMessage(availableUseLeft:uint = 0, closeDate:uint = 0) : PortalDialogQuestionMessage {
         this.availableUseLeft = availableUseLeft;
         this.closeDate = closeDate;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.availableUseLeft = 0;
         this.closeDate = 0;
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
         this.serializeAs_PortalDialogQuestionMessage(output);
      }
      
      public function serializeAs_PortalDialogQuestionMessage(output:IDataOutput) : void {
         if(this.availableUseLeft < 0)
         {
            throw new Error("Forbidden value (" + this.availableUseLeft + ") on element availableUseLeft.");
         }
         else
         {
            output.writeInt(this.availableUseLeft);
            if(this.closeDate < 0)
            {
               throw new Error("Forbidden value (" + this.closeDate + ") on element closeDate.");
            }
            else
            {
               output.writeInt(this.closeDate);
               return;
            }
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_PortalDialogQuestionMessage(input);
      }
      
      public function deserializeAs_PortalDialogQuestionMessage(input:IDataInput) : void {
         this.availableUseLeft = input.readInt();
         if(this.availableUseLeft < 0)
         {
            throw new Error("Forbidden value (" + this.availableUseLeft + ") on element of PortalDialogQuestionMessage.availableUseLeft.");
         }
         else
         {
            this.closeDate = input.readInt();
            if(this.closeDate < 0)
            {
               throw new Error("Forbidden value (" + this.closeDate + ") on element of PortalDialogQuestionMessage.closeDate.");
            }
            else
            {
               return;
            }
         }
      }
   }
}
