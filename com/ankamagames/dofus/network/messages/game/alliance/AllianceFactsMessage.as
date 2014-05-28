package com.ankamagames.dofus.network.messages.game.alliance
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.social.AllianceFactSheetInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GuildInAllianceInformations;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   
   public class AllianceFactsMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function AllianceFactsMessage() {
         this.infos = new AllianceFactSheetInformations();
         this.guilds = new Vector.<GuildInAllianceInformations>();
         this.controlledSubareaIds = new Vector.<uint>();
         super();
      }
      
      public static const protocolId:uint = 6414;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var infos:AllianceFactSheetInformations;
      
      public var guilds:Vector.<GuildInAllianceInformations>;
      
      public var controlledSubareaIds:Vector.<uint>;
      
      override public function getMessageId() : uint {
         return 6414;
      }
      
      public function initAllianceFactsMessage(infos:AllianceFactSheetInformations = null, guilds:Vector.<GuildInAllianceInformations> = null, controlledSubareaIds:Vector.<uint> = null) : AllianceFactsMessage {
         this.infos = infos;
         this.guilds = guilds;
         this.controlledSubareaIds = controlledSubareaIds;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.infos = new AllianceFactSheetInformations();
         this.controlledSubareaIds = new Vector.<uint>();
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
         this.serializeAs_AllianceFactsMessage(output);
      }
      
      public function serializeAs_AllianceFactsMessage(output:IDataOutput) : void {
         output.writeShort(this.infos.getTypeId());
         this.infos.serialize(output);
         output.writeShort(this.guilds.length);
         var _i2:uint = 0;
         while(_i2 < this.guilds.length)
         {
            (this.guilds[_i2] as GuildInAllianceInformations).serializeAs_GuildInAllianceInformations(output);
            _i2++;
         }
         output.writeShort(this.controlledSubareaIds.length);
         var _i3:uint = 0;
         while(_i3 < this.controlledSubareaIds.length)
         {
            if(this.controlledSubareaIds[_i3] < 0)
            {
               throw new Error("Forbidden value (" + this.controlledSubareaIds[_i3] + ") on element 3 (starting at 1) of controlledSubareaIds.");
            }
            else
            {
               output.writeShort(this.controlledSubareaIds[_i3]);
               _i3++;
               continue;
            }
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_AllianceFactsMessage(input);
      }
      
      public function deserializeAs_AllianceFactsMessage(input:IDataInput) : void {
         var _item2:GuildInAllianceInformations = null;
         var _val3:uint = 0;
         var _id1:uint = input.readUnsignedShort();
         this.infos = ProtocolTypeManager.getInstance(AllianceFactSheetInformations,_id1);
         this.infos.deserialize(input);
         var _guildsLen:uint = input.readUnsignedShort();
         var _i2:uint = 0;
         while(_i2 < _guildsLen)
         {
            _item2 = new GuildInAllianceInformations();
            _item2.deserialize(input);
            this.guilds.push(_item2);
            _i2++;
         }
         var _controlledSubareaIdsLen:uint = input.readUnsignedShort();
         var _i3:uint = 0;
         while(_i3 < _controlledSubareaIdsLen)
         {
            _val3 = input.readShort();
            if(_val3 < 0)
            {
               throw new Error("Forbidden value (" + _val3 + ") on elements of controlledSubareaIds.");
            }
            else
            {
               this.controlledSubareaIds.push(_val3);
               _i3++;
               continue;
            }
         }
      }
   }
}
