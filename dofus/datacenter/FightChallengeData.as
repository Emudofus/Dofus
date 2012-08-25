// Action script...

// [Initial MovieClip Action of sprite 20843]
#initclip 108
if (!dofus.datacenter.FightChallengeData)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.datacenter)
    {
        _global.dofus.datacenter = new Object();
    } // end if
    var _loc1 = (_global.dofus.datacenter.FightChallengeData = function (id, showTarget, targetId, basicXpBonus, teamXpBonus, basicDropBonus, teamDropBonus, state)
    {
        super();
        if (_global.isNaN(state))
        {
            this.state = 0;
        }
        else
        {
            this.state = state;
        } // end else if
        this.id = id;
        this.showTarget = showTarget;
        this.targetId = targetId;
        this.basicXpBonus = basicXpBonus;
        this.teamXpBonus = teamXpBonus;
        this.basicDropBonus = basicDropBonus;
        this.teamDropBonus = teamDropBonus;
        var _loc11 = (dofus.utils.Api)(_global.API);
        var _loc12 = _loc11.datacenter.Sprites.getItemAt(targetId).name + " (" + _loc11.lang.getText("LEVEL_SMALL") + " " + _loc11.datacenter.Sprites.getItemAt(targetId).mc.data.Level + ")";
        this.description = _loc11.lang.getFightChallenge(id).d.split("%1").join(_loc12);
        this.iconPath = dofus.Constants.FIGHT_CHALLENGE_PATH + _loc11.lang.getFightChallenge(id).g + ".swf";
    }).prototype;
    _loc1.clone = function ()
    {
        return (new dofus.datacenter.FightChallengeData(this.id, this.showTarget, this.targetId, this.basicXpBonus, this.teamXpBonus, this.basicDropBonus, this.teamDropBonus, this.state));
    };
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
