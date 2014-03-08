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
      
      public function initAllianceModificationStartedMessage(canChangeName:Boolean=false, canChangeTag:Boolean=false, canChangeEmblem:Boolean=false) : AllianceModificationStartedMessage {
         this.canChangeName = canChangeName;
         this.canChangeTag = canChangeTag;
         this.canChangeEmblem = canChangeEmblem;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.canChangeName = false;
         this.canChangeTag = false;
         this.canChangeEmblem = false;
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
         this.serializeAs_AllianceModificationStartedMessage(output);
      }
      
      public function serializeAs_AllianceModificationStartedMessage(output:IDataOutput) : void {
         var _box0:uint = 0;
         _box0 = BooleanByteWrapper.setFlag(_box0,0,this.canChangeName);
         _box0 = BooleanByteWrapper.setFlag(_box0,1,this.canChangeTag);
         _box0 = BooleanByteWrapper.setFlag(_box0,2,this.canChangeEmblem);
         output.writeByte(_box0);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_AllianceModificationStartedMessage(input);
      }
      
      public function deserializeAs_AllianceModificationStartedMessage(input:IDataInput) : void {
         var _box0:uint = input.readByte();
         this.canChangeName = BooleanByteWrapper.getFlag(_box0,0);
         this.canChangeTag = BooleanByteWrapper.getFlag(_box0,1);
         this.canChangeEmblem = BooleanByteWrapper.getFlag(_box0,2);
      }
   }
}
