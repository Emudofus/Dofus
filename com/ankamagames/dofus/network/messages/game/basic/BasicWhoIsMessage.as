package com.ankamagames.dofus.network.messages.game.basic
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import __AS3__.vec.Vector;
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
      
      public function initBasicWhoIsMessage(param1:Boolean=false, param2:int=-1, param3:String="", param4:uint=0, param5:String="", param6:uint=0, param7:int=0, param8:Vector.<AbstractSocialGroupInfos>=null, param9:Boolean=false, param10:uint=99) : BasicWhoIsMessage {
         this.self = param1;
         this.position = param2;
         this.accountNickname = param3;
         this.accountId = param4;
         this.playerName = param5;
         this.playerId = param6;
         this.areaId = param7;
         this.socialGroups = param8;
         this.verbose = param9;
         this.playerState = param10;
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
      
      override public function pack(param1:IDataOutput) : void {
         var _loc2_:ByteArray = new ByteArray();
         this.serialize(_loc2_);
         writePacket(param1,this.getMessageId(),_loc2_);
      }
      
      override public function unpack(param1:IDataInput, param2:uint) : void {
         this.deserialize(param1);
      }
      
      public function serialize(param1:IDataOutput) : void {
         this.serializeAs_BasicWhoIsMessage(param1);
      }
      
      public function serializeAs_BasicWhoIsMessage(param1:IDataOutput) : void {
         var _loc2_:uint = 0;
         _loc2_ = BooleanByteWrapper.setFlag(_loc2_,0,this.self);
         _loc2_ = BooleanByteWrapper.setFlag(_loc2_,1,this.verbose);
         param1.writeByte(_loc2_);
         param1.writeByte(this.position);
         param1.writeUTF(this.accountNickname);
         if(this.accountId < 0)
         {
            throw new Error("Forbidden value (" + this.accountId + ") on element accountId.");
         }
         else
         {
            param1.writeInt(this.accountId);
            param1.writeUTF(this.playerName);
            if(this.playerId < 0)
            {
               throw new Error("Forbidden value (" + this.playerId + ") on element playerId.");
            }
            else
            {
               param1.writeInt(this.playerId);
               param1.writeShort(this.areaId);
               param1.writeShort(this.socialGroups.length);
               _loc3_ = 0;
               while(_loc3_ < this.socialGroups.length)
               {
                  param1.writeShort((this.socialGroups[_loc3_] as AbstractSocialGroupInfos).getTypeId());
                  (this.socialGroups[_loc3_] as AbstractSocialGroupInfos).serialize(param1);
                  _loc3_++;
               }
               param1.writeByte(this.playerState);
               return;
            }
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_BasicWhoIsMessage(param1);
      }
      
      public function deserializeAs_BasicWhoIsMessage(param1:IDataInput) : void {
         var _loc5_:uint = 0;
         var _loc6_:AbstractSocialGroupInfos = null;
         var _loc2_:uint = param1.readByte();
         this.self = BooleanByteWrapper.getFlag(_loc2_,0);
         this.verbose = BooleanByteWrapper.getFlag(_loc2_,1);
         this.position = param1.readByte();
         this.accountNickname = param1.readUTF();
         this.accountId = param1.readInt();
         if(this.accountId < 0)
         {
            throw new Error("Forbidden value (" + this.accountId + ") on element of BasicWhoIsMessage.accountId.");
         }
         else
         {
            this.playerName = param1.readUTF();
            this.playerId = param1.readInt();
            if(this.playerId < 0)
            {
               throw new Error("Forbidden value (" + this.playerId + ") on element of BasicWhoIsMessage.playerId.");
            }
            else
            {
               this.areaId = param1.readShort();
               _loc3_ = param1.readUnsignedShort();
               _loc4_ = 0;
               while(_loc4_ < _loc3_)
               {
                  _loc5_ = param1.readUnsignedShort();
                  _loc6_ = ProtocolTypeManager.getInstance(AbstractSocialGroupInfos,_loc5_);
                  _loc6_.deserialize(param1);
                  this.socialGroups.push(_loc6_);
                  _loc4_++;
               }
               this.playerState = param1.readByte();
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
