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
      
      public function initAllianceCreationValidMessage(allianceName:String = "", allianceTag:String = "", allianceEmblem:GuildEmblem = null) : AllianceCreationValidMessage {
         this.allianceName = allianceName;
         this.allianceTag = allianceTag;
         this.allianceEmblem = allianceEmblem;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.allianceName = "";
         this.allianceTag = "";
         this.allianceEmblem = new GuildEmblem();
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
         this.serializeAs_AllianceCreationValidMessage(output);
      }
      
      public function serializeAs_AllianceCreationValidMessage(output:IDataOutput) : void {
         output.writeUTF(this.allianceName);
         output.writeUTF(this.allianceTag);
         this.allianceEmblem.serializeAs_GuildEmblem(output);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_AllianceCreationValidMessage(input);
      }
      
      public function deserializeAs_AllianceCreationValidMessage(input:IDataInput) : void {
         this.allianceName = input.readUTF();
         this.allianceTag = input.readUTF();
         this.allianceEmblem = new GuildEmblem();
         this.allianceEmblem.deserialize(input);
      }
   }
}
