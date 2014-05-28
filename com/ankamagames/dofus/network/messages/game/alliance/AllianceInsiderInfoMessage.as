package com.ankamagames.dofus.network.messages.game.alliance
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.social.AllianceFactSheetInformations;
   import com.ankamagames.dofus.network.types.game.social.GuildInsiderFactSheetInformations;
   import com.ankamagames.dofus.network.types.game.prism.PrismSubareaEmptyInfo;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   
   public class AllianceInsiderInfoMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function AllianceInsiderInfoMessage() {
         this.allianceInfos = new AllianceFactSheetInformations();
         this.guilds = new Vector.<GuildInsiderFactSheetInformations>();
         this.prisms = new Vector.<PrismSubareaEmptyInfo>();
         super();
      }
      
      public static const protocolId:uint = 6403;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var allianceInfos:AllianceFactSheetInformations;
      
      public var guilds:Vector.<GuildInsiderFactSheetInformations>;
      
      public var prisms:Vector.<PrismSubareaEmptyInfo>;
      
      override public function getMessageId() : uint {
         return 6403;
      }
      
      public function initAllianceInsiderInfoMessage(allianceInfos:AllianceFactSheetInformations = null, guilds:Vector.<GuildInsiderFactSheetInformations> = null, prisms:Vector.<PrismSubareaEmptyInfo> = null) : AllianceInsiderInfoMessage {
         this.allianceInfos = allianceInfos;
         this.guilds = guilds;
         this.prisms = prisms;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.allianceInfos = new AllianceFactSheetInformations();
         this.prisms = new Vector.<PrismSubareaEmptyInfo>();
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
         this.serializeAs_AllianceInsiderInfoMessage(output);
      }
      
      public function serializeAs_AllianceInsiderInfoMessage(output:IDataOutput) : void {
         this.allianceInfos.serializeAs_AllianceFactSheetInformations(output);
         output.writeShort(this.guilds.length);
         var _i2:uint = 0;
         while(_i2 < this.guilds.length)
         {
            (this.guilds[_i2] as GuildInsiderFactSheetInformations).serializeAs_GuildInsiderFactSheetInformations(output);
            _i2++;
         }
         output.writeShort(this.prisms.length);
         var _i3:uint = 0;
         while(_i3 < this.prisms.length)
         {
            output.writeShort((this.prisms[_i3] as PrismSubareaEmptyInfo).getTypeId());
            (this.prisms[_i3] as PrismSubareaEmptyInfo).serialize(output);
            _i3++;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_AllianceInsiderInfoMessage(input);
      }
      
      public function deserializeAs_AllianceInsiderInfoMessage(input:IDataInput) : void {
         var _item2:GuildInsiderFactSheetInformations = null;
         var _id3:uint = 0;
         var _item3:PrismSubareaEmptyInfo = null;
         this.allianceInfos = new AllianceFactSheetInformations();
         this.allianceInfos.deserialize(input);
         var _guildsLen:uint = input.readUnsignedShort();
         var _i2:uint = 0;
         while(_i2 < _guildsLen)
         {
            _item2 = new GuildInsiderFactSheetInformations();
            _item2.deserialize(input);
            this.guilds.push(_item2);
            _i2++;
         }
         var _prismsLen:uint = input.readUnsignedShort();
         var _i3:uint = 0;
         while(_i3 < _prismsLen)
         {
            _id3 = input.readUnsignedShort();
            _item3 = ProtocolTypeManager.getInstance(PrismSubareaEmptyInfo,_id3);
            _item3.deserialize(input);
            this.prisms.push(_item3);
            _i3++;
         }
      }
   }
}
