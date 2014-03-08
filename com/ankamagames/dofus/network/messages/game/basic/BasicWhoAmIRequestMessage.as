package com.ankamagames.dofus.network.messages.game.basic
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class BasicWhoAmIRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function BasicWhoAmIRequestMessage() {
         super();
      }
      
      public static const protocolId:uint = 5664;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var verbose:Boolean = false;
      
      override public function getMessageId() : uint {
         return 5664;
      }
      
      public function initBasicWhoAmIRequestMessage(param1:Boolean=false) : BasicWhoAmIRequestMessage {
         this.verbose = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.verbose = false;
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
         this.serializeAs_BasicWhoAmIRequestMessage(param1);
      }
      
      public function serializeAs_BasicWhoAmIRequestMessage(param1:IDataOutput) : void {
         param1.writeBoolean(this.verbose);
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_BasicWhoAmIRequestMessage(param1);
      }
      
      public function deserializeAs_BasicWhoAmIRequestMessage(param1:IDataInput) : void {
         this.verbose = param1.readBoolean();
      }
   }
}
