package com.ankamagames.dofus.network.messages.game.alliance
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.social.AllianceFactSheetInformations;
   import __AS3__.vec.Vector;
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
      
      public function initAllianceFactsMessage(param1:AllianceFactSheetInformations=null, param2:Vector.<GuildInAllianceInformations>=null, param3:Vector.<uint>=null) : AllianceFactsMessage {
         this.infos = param1;
         this.guilds = param2;
         this.controlledSubareaIds = param3;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.infos = new AllianceFactSheetInformations();
         this.controlledSubareaIds = new Vector.<uint>();
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
         this.serializeAs_AllianceFactsMessage(param1);
      }
      
      public function serializeAs_AllianceFactsMessage(param1:IDataOutput) : void {
         param1.writeShort(this.infos.getTypeId());
         this.infos.serialize(param1);
         param1.writeShort(this.guilds.length);
         var _loc2_:uint = 0;
         while(_loc2_ < this.guilds.length)
         {
            (this.guilds[_loc2_] as GuildInAllianceInformations).serializeAs_GuildInAllianceInformations(param1);
            _loc2_++;
         }
         param1.writeShort(this.controlledSubareaIds.length);
         var _loc3_:uint = 0;
         while(_loc3_ < this.controlledSubareaIds.length)
         {
            if(this.controlledSubareaIds[_loc3_] < 0)
            {
               throw new Error("Forbidden value (" + this.controlledSubareaIds[_loc3_] + ") on element 3 (starting at 1) of controlledSubareaIds.");
            }
            else
            {
               param1.writeShort(this.controlledSubareaIds[_loc3_]);
               _loc3_++;
               continue;
            }
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_AllianceFactsMessage(param1);
      }
      
      public function deserializeAs_AllianceFactsMessage(param1:IDataInput) : void {
         var _loc7_:GuildInAllianceInformations = null;
         var _loc8_:uint = 0;
         var _loc2_:uint = param1.readUnsignedShort();
         this.infos = ProtocolTypeManager.getInstance(AllianceFactSheetInformations,_loc2_);
         this.infos.deserialize(param1);
         var _loc3_:uint = param1.readUnsignedShort();
         var _loc4_:uint = 0;
         while(_loc4_ < _loc3_)
         {
            _loc7_ = new GuildInAllianceInformations();
            _loc7_.deserialize(param1);
            this.guilds.push(_loc7_);
            _loc4_++;
         }
         var _loc5_:uint = param1.readUnsignedShort();
         var _loc6_:uint = 0;
         while(_loc6_ < _loc5_)
         {
            _loc8_ = param1.readShort();
            if(_loc8_ < 0)
            {
               throw new Error("Forbidden value (" + _loc8_ + ") on elements of controlledSubareaIds.");
            }
            else
            {
               this.controlledSubareaIds.push(_loc8_);
               _loc6_++;
               continue;
            }
         }
      }
   }
}
