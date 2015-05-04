package com.ankamagames.dofus.network.messages.game.alliance
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class AllianceModificationNameAndTagValidMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function AllianceModificationNameAndTagValidMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 6449;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var allianceName:String = "";
      
      public var allianceTag:String = "";
      
      override public function getMessageId() : uint
      {
         return 6449;
      }
      
      public function initAllianceModificationNameAndTagValidMessage(param1:String = "", param2:String = "") : AllianceModificationNameAndTagValidMessage
      {
         this.allianceName = param1;
         this.allianceTag = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.allianceName = "";
         this.allianceTag = "";
         this._isInitialized = false;
      }
      
      override public function pack(param1:ICustomDataOutput) : void
      {
         var _loc2_:ByteArray = new ByteArray();
         this.serialize(new CustomDataWrapper(_loc2_));
         writePacket(param1,this.getMessageId(),_loc2_);
      }
      
      override public function unpack(param1:ICustomDataInput, param2:uint) : void
      {
         this.deserialize(param1);
      }
      
      public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_AllianceModificationNameAndTagValidMessage(param1);
      }
      
      public function serializeAs_AllianceModificationNameAndTagValidMessage(param1:ICustomDataOutput) : void
      {
         param1.writeUTF(this.allianceName);
         param1.writeUTF(this.allianceTag);
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_AllianceModificationNameAndTagValidMessage(param1);
      }
      
      public function deserializeAs_AllianceModificationNameAndTagValidMessage(param1:ICustomDataInput) : void
      {
         this.allianceName = param1.readUTF();
         this.allianceTag = param1.readUTF();
      }
   }
}
