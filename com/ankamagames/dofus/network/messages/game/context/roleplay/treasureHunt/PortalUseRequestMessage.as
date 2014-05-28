package com.ankamagames.dofus.network.messages.game.context.roleplay.treasureHunt
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class PortalUseRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function PortalUseRequestMessage() {
         super();
      }
      
      public static const protocolId:uint = 6492;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var portalId:uint = 0;
      
      override public function getMessageId() : uint {
         return 6492;
      }
      
      public function initPortalUseRequestMessage(portalId:uint = 0) : PortalUseRequestMessage {
         this.portalId = portalId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.portalId = 0;
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
         this.serializeAs_PortalUseRequestMessage(output);
      }
      
      public function serializeAs_PortalUseRequestMessage(output:IDataOutput) : void {
         if(this.portalId < 0)
         {
            throw new Error("Forbidden value (" + this.portalId + ") on element portalId.");
         }
         else
         {
            output.writeInt(this.portalId);
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_PortalUseRequestMessage(input);
      }
      
      public function deserializeAs_PortalUseRequestMessage(input:IDataInput) : void {
         this.portalId = input.readInt();
         if(this.portalId < 0)
         {
            throw new Error("Forbidden value (" + this.portalId + ") on element of PortalUseRequestMessage.portalId.");
         }
         else
         {
            return;
         }
      }
   }
}
