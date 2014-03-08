package com.ankamagames.dofus.network.messages.handshake
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ProtocolRequired extends NetworkMessage implements INetworkMessage
   {
      
      public function ProtocolRequired() {
         super();
      }
      
      public static const protocolId:uint = 1;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var requiredVersion:uint = 0;
      
      public var currentVersion:uint = 0;
      
      override public function getMessageId() : uint {
         return 1;
      }
      
      public function initProtocolRequired(requiredVersion:uint=0, currentVersion:uint=0) : ProtocolRequired {
         this.requiredVersion = requiredVersion;
         this.currentVersion = currentVersion;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.requiredVersion = 0;
         this.currentVersion = 0;
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
         this.serializeAs_ProtocolRequired(output);
      }
      
      public function serializeAs_ProtocolRequired(output:IDataOutput) : void {
         if(this.requiredVersion < 0)
         {
            throw new Error("Forbidden value (" + this.requiredVersion + ") on element requiredVersion.");
         }
         else
         {
            output.writeInt(this.requiredVersion);
            if(this.currentVersion < 0)
            {
               throw new Error("Forbidden value (" + this.currentVersion + ") on element currentVersion.");
            }
            else
            {
               output.writeInt(this.currentVersion);
               return;
            }
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ProtocolRequired(input);
      }
      
      public function deserializeAs_ProtocolRequired(input:IDataInput) : void {
         this.requiredVersion = input.readInt();
         if(this.requiredVersion < 0)
         {
            throw new Error("Forbidden value (" + this.requiredVersion + ") on element of ProtocolRequired.requiredVersion.");
         }
         else
         {
            this.currentVersion = input.readInt();
            if(this.currentVersion < 0)
            {
               throw new Error("Forbidden value (" + this.currentVersion + ") on element of ProtocolRequired.currentVersion.");
            }
            else
            {
               return;
            }
         }
      }
   }
}
