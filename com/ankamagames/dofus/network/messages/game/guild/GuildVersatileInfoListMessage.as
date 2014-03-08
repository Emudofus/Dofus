package com.ankamagames.dofus.network.messages.game.guild
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import __AS3__.vec.Vector;
   import com.ankamagames.dofus.network.types.game.social.GuildVersatileInformations;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   
   public class GuildVersatileInfoListMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function GuildVersatileInfoListMessage() {
         this.guilds = new Vector.<GuildVersatileInformations>();
         super();
      }
      
      public static const protocolId:uint = 6435;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var guilds:Vector.<GuildVersatileInformations>;
      
      override public function getMessageId() : uint {
         return 6435;
      }
      
      public function initGuildVersatileInfoListMessage(param1:Vector.<GuildVersatileInformations>=null) : GuildVersatileInfoListMessage {
         this.guilds = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.guilds = new Vector.<GuildVersatileInformations>();
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
         this.serializeAs_GuildVersatileInfoListMessage(param1);
      }
      
      public function serializeAs_GuildVersatileInfoListMessage(param1:IDataOutput) : void {
         param1.writeShort(this.guilds.length);
         var _loc2_:uint = 0;
         while(_loc2_ < this.guilds.length)
         {
            param1.writeShort((this.guilds[_loc2_] as GuildVersatileInformations).getTypeId());
            (this.guilds[_loc2_] as GuildVersatileInformations).serialize(param1);
            _loc2_++;
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_GuildVersatileInfoListMessage(param1);
      }
      
      public function deserializeAs_GuildVersatileInfoListMessage(param1:IDataInput) : void {
         var _loc4_:uint = 0;
         var _loc5_:GuildVersatileInformations = null;
         var _loc2_:uint = param1.readUnsignedShort();
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = param1.readUnsignedShort();
            _loc5_ = ProtocolTypeManager.getInstance(GuildVersatileInformations,_loc4_);
            _loc5_.deserialize(param1);
            this.guilds.push(_loc5_);
            _loc3_++;
         }
      }
   }
}
