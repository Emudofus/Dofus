package com.ankamagames.dofus.network.messages.game.alliance
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.guild.GuildEmblem;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class AllianceCreationValidMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function AllianceCreationValidMessage() {
         this.allianceEmblem = new GuildEmblem();
         super();
      }
      
      public static const protocolId:uint = 6393;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var allianceName:String = "";
      
      public var allianceTag:String = "";
      
      public var allianceEmblem:GuildEmblem;
      
      override public function getMessageId() : uint {
         return 6393;
      }
      
      public function initAllianceCreationValidMessage(param1:String="", param2:String="", param3:GuildEmblem=null) : AllianceCreationValidMessage {
         this.allianceName = param1;
         this.allianceTag = param2;
         this.allianceEmblem = param3;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.allianceName = "";
         this.allianceTag = "";
         this.allianceEmblem = new GuildEmblem();
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
         this.serializeAs_AllianceCreationValidMessage(param1);
      }
      
      public function serializeAs_AllianceCreationValidMessage(param1:IDataOutput) : void {
         param1.writeUTF(this.allianceName);
         param1.writeUTF(this.allianceTag);
         this.allianceEmblem.serializeAs_GuildEmblem(param1);
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_AllianceCreationValidMessage(param1);
      }
      
      public function deserializeAs_AllianceCreationValidMessage(param1:IDataInput) : void {
         this.allianceName = param1.readUTF();
         this.allianceTag = param1.readUTF();
         this.allianceEmblem = new GuildEmblem();
         this.allianceEmblem.deserialize(param1);
      }
   }
}
