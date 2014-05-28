package com.ankamagames.dofus.network.messages.connection.register
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class NicknameChoiceRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function NicknameChoiceRequestMessage() {
         super();
      }
      
      public static const protocolId:uint = 5639;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var nickname:String = "";
      
      override public function getMessageId() : uint {
         return 5639;
      }
      
      public function initNicknameChoiceRequestMessage(nickname:String = "") : NicknameChoiceRequestMessage {
         this.nickname = nickname;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.nickname = "";
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
         this.serializeAs_NicknameChoiceRequestMessage(output);
      }
      
      public function serializeAs_NicknameChoiceRequestMessage(output:IDataOutput) : void {
         output.writeUTF(this.nickname);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_NicknameChoiceRequestMessage(input);
      }
      
      public function deserializeAs_NicknameChoiceRequestMessage(input:IDataInput) : void {
         this.nickname = input.readUTF();
      }
   }
}
