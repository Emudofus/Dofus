package com.ankamagames.dofus.network.messages.connection
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class IdentificationSuccessWithLoginTokenMessage extends IdentificationSuccessMessage implements INetworkMessage
   {
      
      public function IdentificationSuccessWithLoginTokenMessage() {
         super();
      }
      
      public static const protocolId:uint = 6209;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var loginToken:String = "";
      
      override public function getMessageId() : uint {
         return 6209;
      }
      
      public function initIdentificationSuccessWithLoginTokenMessage(param1:String="", param2:String="", param3:uint=0, param4:uint=0, param5:Boolean=false, param6:String="", param7:Number=0, param8:Boolean=false, param9:Number=0, param10:String="") : IdentificationSuccessWithLoginTokenMessage {
         super.initIdentificationSuccessMessage(param1,param2,param3,param4,param5,param6,param7,param8,param9);
         this.loginToken = param10;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.loginToken = "";
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
      
      override public function serialize(param1:IDataOutput) : void {
         this.serializeAs_IdentificationSuccessWithLoginTokenMessage(param1);
      }
      
      public function serializeAs_IdentificationSuccessWithLoginTokenMessage(param1:IDataOutput) : void {
         super.serializeAs_IdentificationSuccessMessage(param1);
         param1.writeUTF(this.loginToken);
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_IdentificationSuccessWithLoginTokenMessage(param1);
      }
      
      public function deserializeAs_IdentificationSuccessWithLoginTokenMessage(param1:IDataInput) : void {
         super.deserialize(param1);
         this.loginToken = param1.readUTF();
      }
   }
}
