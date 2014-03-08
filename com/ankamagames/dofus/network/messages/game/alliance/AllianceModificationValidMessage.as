package com.ankamagames.dofus.network.messages.game.alliance
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.guild.GuildEmblem;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class AllianceModificationValidMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function AllianceModificationValidMessage() {
         this.Alliancemblem = new GuildEmblem();
         super();
      }
      
      public static const protocolId:uint = 6450;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var allianceName:String = "";
      
      public var allianceTag:String = "";
      
      public var Alliancemblem:GuildEmblem;
      
      override public function getMessageId() : uint {
         return 6450;
      }
      
      public function initAllianceModificationValidMessage(allianceName:String="", allianceTag:String="", Alliancemblem:GuildEmblem=null) : AllianceModificationValidMessage {
         this.allianceName = allianceName;
         this.allianceTag = allianceTag;
         this.Alliancemblem = Alliancemblem;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.allianceName = "";
         this.allianceTag = "";
         this.Alliancemblem = new GuildEmblem();
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
         this.serializeAs_AllianceModificationValidMessage(output);
      }
      
      public function serializeAs_AllianceModificationValidMessage(output:IDataOutput) : void {
         output.writeUTF(this.allianceName);
         output.writeUTF(this.allianceTag);
         this.Alliancemblem.serializeAs_GuildEmblem(output);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_AllianceModificationValidMessage(input);
      }
      
      public function deserializeAs_AllianceModificationValidMessage(input:IDataInput) : void {
         this.allianceName = input.readUTF();
         this.allianceTag = input.readUTF();
         this.Alliancemblem = new GuildEmblem();
         this.Alliancemblem.deserialize(input);
      }
   }
}
