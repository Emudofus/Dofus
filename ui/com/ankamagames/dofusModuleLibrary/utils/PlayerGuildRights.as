package com.ankamagames.dofusModuleLibrary.utils
{
   public class PlayerGuildRights extends Object
   {
      
      public function PlayerGuildRights() {
         super();
      }
      
      public static function isBoss(pPlayerRights:uint) : Boolean {
         return (1 & pPlayerRights) > 0;
      }
      
      public static function manageGuildBoosts(pPlayerRights:uint) : Boolean {
         return (isBoss(pPlayerRights)) || ((2 & pPlayerRights) > 0);
      }
      
      public static function manageRights(pPlayerRights:uint) : Boolean {
         return (isBoss(pPlayerRights)) || ((4 & pPlayerRights) > 0);
      }
      
      public static function inviteNewMembers(pPlayerRights:uint) : Boolean {
         return (isBoss(pPlayerRights)) || ((8 & pPlayerRights) > 0);
      }
      
      public static function banMembers(pPlayerRights:uint) : Boolean {
         return (isBoss(pPlayerRights)) || ((16 & pPlayerRights) > 0);
      }
      
      public static function manageXPContribution(pPlayerRights:uint) : Boolean {
         return (isBoss(pPlayerRights)) || ((32 & pPlayerRights) > 0);
      }
      
      public static function manageRanks(pPlayerRights:uint) : Boolean {
         return (isBoss(pPlayerRights)) || ((64 & pPlayerRights) > 0);
      }
      
      public static function manageMyXpContribution(pPlayerRights:uint) : Boolean {
         return (isBoss(pPlayerRights)) || ((128 & pPlayerRights) > 0);
      }
      
      public static function hireTaxCollector(pPlayerRights:uint) : Boolean {
         return (isBoss(pPlayerRights)) || ((256 & pPlayerRights) > 0);
      }
      
      public static function collect(pPlayerRights:uint) : Boolean {
         return (isBoss(pPlayerRights)) || ((512 & pPlayerRights) > 0);
      }
      
      public static function manageLightRights(pPlayerRights:uint) : Boolean {
         return (isBoss(pPlayerRights)) || ((1024 & pPlayerRights) > 0);
      }
      
      public static function useFarms(pPlayerRights:uint) : Boolean {
         return (isBoss(pPlayerRights)) || ((4096 & pPlayerRights) > 0);
      }
      
      public static function organizeFarms(pPlayerRights:uint) : Boolean {
         return (isBoss(pPlayerRights)) || ((8192 & pPlayerRights) > 0);
      }
      
      public static function takeOthersRidesInFarm(pPlayerRights:uint) : Boolean {
         return (isBoss(pPlayerRights)) || ((16384 & pPlayerRights) > 0);
      }
   }
}
