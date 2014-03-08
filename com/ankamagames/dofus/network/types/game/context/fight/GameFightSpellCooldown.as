package com.ankamagames.dofus.network.types.game.context.fight
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class GameFightSpellCooldown extends Object implements INetworkType
   {
      
      public function GameFightSpellCooldown() {
         super();
      }
      
      public static const protocolId:uint = 205;
      
      public var spellId:int = 0;
      
      public var cooldown:uint = 0;
      
      public function getTypeId() : uint {
         return 205;
      }
      
      public function initGameFightSpellCooldown(param1:int=0, param2:uint=0) : GameFightSpellCooldown {
         this.spellId = param1;
         this.cooldown = param2;
         return this;
      }
      
      public function reset() : void {
         this.spellId = 0;
         this.cooldown = 0;
      }
      
      public function serialize(param1:IDataOutput) : void {
         this.serializeAs_GameFightSpellCooldown(param1);
      }
      
      public function serializeAs_GameFightSpellCooldown(param1:IDataOutput) : void {
         param1.writeInt(this.spellId);
         if(this.cooldown < 0)
         {
            throw new Error("Forbidden value (" + this.cooldown + ") on element cooldown.");
         }
         else
         {
            param1.writeByte(this.cooldown);
            return;
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_GameFightSpellCooldown(param1);
      }
      
      public function deserializeAs_GameFightSpellCooldown(param1:IDataInput) : void {
         this.spellId = param1.readInt();
         this.cooldown = param1.readByte();
         if(this.cooldown < 0)
         {
            throw new Error("Forbidden value (" + this.cooldown + ") on element of GameFightSpellCooldown.cooldown.");
         }
         else
         {
            return;
         }
      }
   }
}
