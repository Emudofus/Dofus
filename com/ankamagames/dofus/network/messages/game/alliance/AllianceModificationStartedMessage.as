package com.ankamagames.dofus.network.messages.game.alliance
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   import com.ankamagames.jerakine.network.utils.BooleanByteWrapper;
   
   public class AllianceModificationStartedMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function AllianceModificationStartedMessage() {
         super();
      }
      
      public static const protocolId:uint = 6444;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var canChangeName:Boolean = false;
      
      public var canChangeTag:Boolean = false;
      
      public var canChangeEmblem:Boolean = false;
      
      override public function getMessageId() : uint {
         return 6444;
      }
      
      public function initAllianceModificationStartedMessage(param1:Boolean=false, param2:Boolean=false, param3:Boolean=false) : AllianceModificationStartedMessage {
         this.canChangeName = param1;
         this.canChangeTag = param2;
         this.canChangeEmblem = param3;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.canChangeName = false;
         this.canChangeTag = false;
         this.canChangeEmblem = false;
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
         this.serializeAs_AllianceModificationStartedMessage(param1);
      }
      
      public function serializeAs_AllianceModificationStartedMessage(param1:IDataOutput) : void {
         var _loc2_:uint = 0;
         _loc2_ = BooleanByteWrapper.setFlag(_loc2_,0,this.canChangeName);
         _loc2_ = BooleanByteWrapper.setFlag(_loc2_,1,this.canChangeTag);
         _loc2_ = BooleanByteWrapper.setFlag(_loc2_,2,this.canChangeEmblem);
         param1.writeByte(_loc2_);
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_AllianceModificationStartedMessage(param1);
      }
      
      public function deserializeAs_AllianceModificationStartedMessage(param1:IDataInput) : void {
         var _loc2_:uint = param1.readByte();
         this.canChangeName = BooleanByteWrapper.getFlag(_loc2_,0);
         this.canChangeTag = BooleanByteWrapper.getFlag(_loc2_,1);
         this.canChangeEmblem = BooleanByteWrapper.getFlag(_loc2_,2);
      }
   }
}
