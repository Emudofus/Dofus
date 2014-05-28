package com.ankamagames.dofus.network.messages.game.basic
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.social.AbstractSocialGroupInfos;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   import com.ankamagames.jerakine.network.utils.BooleanByteWrapper;
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   
   public class BasicWhoIsMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function BasicWhoIsMessage() {
         this.socialGroups = new Vector.<AbstractSocialGroupInfos>();
         super();
      }
      
      public static const protocolId:uint = 180;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var self:Boolean = false;
      
      public var position:int = -1;
      
      public var accountNickname:String = "";
      
      public var accountId:uint = 0;
      
      public var playerName:String = "";
      
      public var playerId:uint = 0;
      
      public var areaId:int = 0;
      
      public var socialGroups:Vector.<AbstractSocialGroupInfos>;
      
      public var verbose:Boolean = false;
      
      public var playerState:uint = 99;
      
      override public function getMessageId() : uint {
         return 180;
      }
      
      public function initBasicWhoIsMessage(self:Boolean = false, position:int = -1, accountNickname:String = "", accountId:uint = 0, playerName:String = "", playerId:uint = 0, areaId:int = 0, socialGroups:Vector.<AbstractSocialGroupInfos> = null, verbose:Boolean = false, playerState:uint = 99) : BasicWhoIsMessage {
         this.self = self;
         this.position = position;
         this.accountNickname = accountNickname;
         this.accountId = accountId;
         this.playerName = playerName;
         this.playerId = playerId;
         this.areaId = areaId;
         this.socialGroups = socialGroups;
         this.verbose = verbose;
         this.playerState = playerState;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.self = false;
         this.position = -1;
         this.accountNickname = "";
         this.accountId = 0;
         this.playerName = "";
         this.playerId = 0;
         this.areaId = 0;
         this.socialGroups = new Vector.<AbstractSocialGroupInfos>();
         this.verbose = false;
         this.playerState = 99;
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
         this.serializeAs_BasicWhoIsMessage(output);
      }
      
      public function serializeAs_BasicWhoIsMessage(output:IDataOutput) : void {
         var _box0:uint = 0;
         _box0 = BooleanByteWrapper.setFlag(_box0,0,this.self);
         _box0 = BooleanByteWrapper.setFlag(_box0,1,this.verbose);
         output.writeByte(_box0);
         output.writeByte(this.position);
         output.writeUTF(this.accountNickname);
         if(this.accountId < 0)
         {
            throw new Error("Forbidden value (" + this.accountId + ") on element accountId.");
         }
         else
         {
            output.writeInt(this.accountId);
            output.writeUTF(this.playerName);
            if(this.playerId < 0)
            {
               throw new Error("Forbidden value (" + this.playerId + ") on element playerId.");
            }
            else
            {
               output.writeInt(this.playerId);
               output.writeShort(this.areaId);
               output.writeShort(this.socialGroups.length);
               _i8 = 0;
               while(_i8 < this.socialGroups.length)
               {
                  output.writeShort((this.socialGroups[_i8] as AbstractSocialGroupInfos).getTypeId());
                  (this.socialGroups[_i8] as AbstractSocialGroupInfos).serialize(output);
                  _i8++;
               }
               output.writeByte(this.playerState);
               return;
            }
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_BasicWhoIsMessage(input);
      }
      
      public function deserializeAs_BasicWhoIsMessage(input:IDataInput) : void {
         var _id8:uint = 0;
         var _item8:AbstractSocialGroupInfos = null;
         var _box0:uint = input.readByte();
         this.self = BooleanByteWrapper.getFlag(_box0,0);
         this.verbose = BooleanByteWrapper.getFlag(_box0,1);
         this.position = input.readByte();
         this.accountNickname = input.readUTF();
         this.accountId = input.readInt();
         if(this.accountId < 0)
         {
            throw new Error("Forbidden value (" + this.accountId + ") on element of BasicWhoIsMessage.accountId.");
         }
         else
         {
            this.playerName = input.readUTF();
            this.playerId = input.readInt();
            if(this.playerId < 0)
            {
               throw new Error("Forbidden value (" + this.playerId + ") on element of BasicWhoIsMessage.playerId.");
            }
            else
            {
               this.areaId = input.readShort();
               _socialGroupsLen = input.readUnsignedShort();
               _i8 = 0;
               while(_i8 < _socialGroupsLen)
               {
                  _id8 = input.readUnsignedShort();
                  _item8 = ProtocolTypeManager.getInstance(AbstractSocialGroupInfos,_id8);
                  _item8.deserialize(input);
                  this.socialGroups.push(_item8);
                  _i8++;
               }
               this.playerState = input.readByte();
               if(this.playerState < 0)
               {
                  throw new Error("Forbidden value (" + this.playerState + ") on element of BasicWhoIsMessage.playerState.");
               }
               else
               {
                  return;
               }
            }
         }
      }
   }
}
