package com.ankamagames.dofus.network.messages.game.friend
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   import com.ankamagames.jerakine.network.utils.BooleanByteWrapper;
   
   public class IgnoredDeleteResultMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function IgnoredDeleteResultMessage() {
         super();
      }
      
      public static const protocolId:uint = 5677;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var success:Boolean = false;
      
      public var name:String = "";
      
      public var session:Boolean = false;
      
      override public function getMessageId() : uint {
         return 5677;
      }
      
      public function initIgnoredDeleteResultMessage(param1:Boolean=false, param2:String="", param3:Boolean=false) : IgnoredDeleteResultMessage {
         this.success = param1;
         this.name = param2;
         this.session = param3;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.success = false;
         this.name = "";
         this.session = false;
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
         this.serializeAs_IgnoredDeleteResultMessage(param1);
      }
      
      public function serializeAs_IgnoredDeleteResultMessage(param1:IDataOutput) : void {
         var _loc2_:uint = 0;
         _loc2_ = BooleanByteWrapper.setFlag(_loc2_,0,this.success);
         _loc2_ = BooleanByteWrapper.setFlag(_loc2_,1,this.session);
         param1.writeByte(_loc2_);
         param1.writeUTF(this.name);
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_IgnoredDeleteResultMessage(param1);
      }
      
      public function deserializeAs_IgnoredDeleteResultMessage(param1:IDataInput) : void {
         var _loc2_:uint = param1.readByte();
         this.success = BooleanByteWrapper.getFlag(_loc2_,0);
         this.session = BooleanByteWrapper.getFlag(_loc2_,1);
         this.name = param1.readUTF();
      }
   }
}
