package com.ankamagames.dofus.network.types.game.context.roleplay.quest
{
   import com.ankamagames.jerakine.network.INetworkType;
   import __AS3__.vec.Vector;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class GameRolePlayNpcQuestFlag extends Object implements INetworkType
   {
      
      public function GameRolePlayNpcQuestFlag() {
         this.questsToValidId = new Vector.<uint>();
         this.questsToStartId = new Vector.<uint>();
         super();
      }
      
      public static const protocolId:uint = 384;
      
      public var questsToValidId:Vector.<uint>;
      
      public var questsToStartId:Vector.<uint>;
      
      public function getTypeId() : uint {
         return 384;
      }
      
      public function initGameRolePlayNpcQuestFlag(param1:Vector.<uint>=null, param2:Vector.<uint>=null) : GameRolePlayNpcQuestFlag {
         this.questsToValidId = param1;
         this.questsToStartId = param2;
         return this;
      }
      
      public function reset() : void {
         this.questsToValidId = new Vector.<uint>();
         this.questsToStartId = new Vector.<uint>();
      }
      
      public function serialize(param1:IDataOutput) : void {
         this.serializeAs_GameRolePlayNpcQuestFlag(param1);
      }
      
      public function serializeAs_GameRolePlayNpcQuestFlag(param1:IDataOutput) : void {
         param1.writeShort(this.questsToValidId.length);
         var _loc2_:uint = 0;
         while(_loc2_ < this.questsToValidId.length)
         {
            if(this.questsToValidId[_loc2_] < 0)
            {
               throw new Error("Forbidden value (" + this.questsToValidId[_loc2_] + ") on element 1 (starting at 1) of questsToValidId.");
            }
            else
            {
               param1.writeShort(this.questsToValidId[_loc2_]);
               _loc2_++;
               continue;
            }
         }
         param1.writeShort(this.questsToStartId.length);
         var _loc3_:uint = 0;
         while(_loc3_ < this.questsToStartId.length)
         {
            if(this.questsToStartId[_loc3_] < 0)
            {
               throw new Error("Forbidden value (" + this.questsToStartId[_loc3_] + ") on element 2 (starting at 1) of questsToStartId.");
            }
            else
            {
               param1.writeShort(this.questsToStartId[_loc3_]);
               _loc3_++;
               continue;
            }
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_GameRolePlayNpcQuestFlag(param1);
      }
      
      public function deserializeAs_GameRolePlayNpcQuestFlag(param1:IDataInput) : void {
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc2_:uint = param1.readUnsignedShort();
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_)
         {
            _loc6_ = param1.readShort();
            if(_loc6_ < 0)
            {
               throw new Error("Forbidden value (" + _loc6_ + ") on elements of questsToValidId.");
            }
            else
            {
               this.questsToValidId.push(_loc6_);
               _loc3_++;
               continue;
            }
         }
         var _loc4_:uint = param1.readUnsignedShort();
         var _loc5_:uint = 0;
         while(_loc5_ < _loc4_)
         {
            _loc7_ = param1.readShort();
            if(_loc7_ < 0)
            {
               throw new Error("Forbidden value (" + _loc7_ + ") on elements of questsToStartId.");
            }
            else
            {
               this.questsToStartId.push(_loc7_);
               _loc5_++;
               continue;
            }
         }
      }
   }
}
