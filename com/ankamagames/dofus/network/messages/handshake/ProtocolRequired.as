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
      
      public function initProtocolRequired(param1:uint=0, param2:uint=0) : ProtocolRequired {
         this.requiredVersion = param1;
         this.currentVersion = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.requiredVersion = 0;
         this.currentVersion = 0;
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
      
      public function serialize(param1:IDataOutput) : void {
         this.serializeAs_ProtocolRequired(param1);
      }
      
      public function serializeAs_ProtocolRequired(param1:IDataOutput) : void {
         if(this.requiredVersion < 0)
         {
            throw new Error("Forbidden value (" + this.requiredVersion + ") on element requiredVersion.");
         }
         else
         {
            param1.writeInt(this.requiredVersion);
            if(this.currentVersion < 0)
            {
               throw new Error("Forbidden value (" + this.currentVersion + ") on element currentVersion.");
            }
            else
            {
               param1.writeInt(this.currentVersion);
               return;
            }
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_ProtocolRequired(param1);
      }
      
      public function deserializeAs_ProtocolRequired(param1:IDataInput) : void {
         this.requiredVersion = param1.readInt();
         if(this.requiredVersion < 0)
         {
            throw new Error("Forbidden value (" + this.requiredVersion + ") on element of ProtocolRequired.requiredVersion.");
         }
         else
         {
            this.currentVersion = param1.readInt();
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
