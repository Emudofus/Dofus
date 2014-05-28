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
      
      public function initIdentificationSuccessWithLoginTokenMessage(login:String = "", nickname:String = "", accountId:uint = 0, communityId:uint = 0, hasRights:Boolean = false, secretQuestion:String = "", subscriptionEndDate:Number = 0, wasAlreadyConnected:Boolean = false, accountCreation:Number = 0, loginToken:String = "") : IdentificationSuccessWithLoginTokenMessage {
         super.initIdentificationSuccessMessage(login,nickname,accountId,communityId,hasRights,secretQuestion,subscriptionEndDate,wasAlreadyConnected,accountCreation);
         this.loginToken = loginToken;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.loginToken = "";
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
      
      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_IdentificationSuccessWithLoginTokenMessage(output);
      }
      
      public function serializeAs_IdentificationSuccessWithLoginTokenMessage(output:IDataOutput) : void {
         super.serializeAs_IdentificationSuccessMessage(output);
         output.writeUTF(this.loginToken);
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_IdentificationSuccessWithLoginTokenMessage(input);
      }
      
      public function deserializeAs_IdentificationSuccessWithLoginTokenMessage(input:IDataInput) : void {
         super.deserialize(input);
         this.loginToken = input.readUTF();
      }
   }
}
