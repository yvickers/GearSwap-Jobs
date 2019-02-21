-------------------------------------------------------------------------------------------------------------------
--  Keybinds
-------------------------------------------------------------------------------------------------------------------

--  Modes:      [ F9 ]              Cycle Offense Modes
--              [ CTRL+F9 ]         Cycle Hybrid Modes
--              [ ALT+F9 ]          Cycle Ranged Modes
--              [ WIN+F9 ]          Cycle Weapon Skill Modes
--              [ F10 ]             Emergency -PDT Mode
--              [ ALT+F10 ]         Toggle Kiting Mode
--              [ F11 ]             Emergency -MDT Mode
--              [ F12 ]             Update Current Gear / Report Current Status
--              [ CTRL+F12 ]        Cycle Idle Modes
--              [ ALT+F12 ]         Cancel Emergency -PDT/-MDT Mode
--              [ WIN+C ]           Toggle Capacity Points Mode
--              [ WIN+L ]           Toggle use of Luzaf Ring.
--              [ WIN+Q ]           Quick Draw shot mode selector.
--
--  Abilities:  [ CTRL+- ]          Quick Draw primary shot element cycle forward.
--              [ CTRL+= ]          Quick Draw primary shot element cycle backward.
--              [ ALT+- ]           Quick Draw secondary shot element cycle forward.
--              [ ALT+= ]           Quick Draw secondary shot element cycle backward.
--              [ CTRL+[ ]          Quick Draw toggle target type.
--              [ CTRL+] ]          Quick Draw toggle use secondary shot.

-------------------------------------------------------------------------------------------------------------------
--  Custom Commands (preface with /console to use these in macros)
-------------------------------------------------------------------------------------------------------------------

--  gs c qd                         Uses the currently configured shot on the target, with either <t> or
--                                  <stnpc> depending on setting.
--  gs c qd t                       Uses the currently configured shot on the target, but forces use of <t>.
--
--  gs c cycle mainqd               Cycles through the available steps to use as the primary shot when using
--                                  one of the above commands.
--  gs c cycle altqd                Cycles through the available steps to use for alternating with the
--                                  configured main shot.
--  gs c toggle usealtqd            Toggles whether or not to use an alternate shot.
--  gs c toggle selectqdtarget      Toggles whether or not to use <stnpc> (as opposed to <t>) when using a shot.
--
--  gs c toggle LuzafRing           Toggles use of Luzaf Ring on and off
--  gs c toggle CP                  Toggles locking of CP cape

-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
    
    --Player specific global gear
    include('Mishrahh-Gear.lua')

    -- Load and initialize the include file.
    include('Mote-Include.lua')
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    -- Whether to use Luzaf's Ring
    state.LuzafRing = M(true, "Luzaf's Ring")
    state.UseCompensator = M(false, "Compensator" )
    -- Whether a warning has been given for low ammo
    state.warned = M(false)

    -- QuickDraw Selector
    state.Mainqd = M{['description']='Primary Shot', 'Light Shot', 'Dark Shot', 'Fire Shot', 'Ice Shot', 'Wind Shot', 'Earth Shot', 'Thunder Shot', 'Water Shot'}
    state.Altqd = M{['description']='Secondary Shot', 'Dark Shot', 'Fire Shot', 'Ice Shot', 'Wind Shot', 'Earth Shot', 'Thunder Shot', 'Water Shot', 'Light Shot'}
    state.UseAltqd = M(false, 'Use Secondary Shot')
    state.SelectqdTarget = M(true, 'Select Quick Draw Target')
    state.Currentqd = M{['description']='Current Quick Draw', 'Main', 'Alt'}

    -- Rolls Selector
    state.MainRoll = M{['description']='Main Roll', 'Chaos Roll', 'Choral Roll', 'Companion\'s Roll', 'Corsair\'s Roll', 'Courser\'s Roll', 'Dancer\'s Roll', 'Drachen Roll', 'Evoker\'s Roll', 'Fighter\'s Roll', 'Gallant\'s Roll', 'Healer\'s Roll', 'Hunter\'s Roll', 'Magus\'s Roll', 'Miser\'s Roll', 'Monk\'s Roll', 'Ninja Roll', 'Puppet Roll', 'Rogue\'s Roll', 'Samurai Roll', 'Scholar\'s Roll', 'Tactician\'s Roll', 'Warlock\'s Roll', 'Wizard\'s Roll','Allies\'s Roll', 'Avenger\'s Roll', 'Beast Roll', 'Blitzer\'s Roll', 'Bolter\'s Roll', 'Caster\'s Roll' }
    state.SecondaryRoll = M{['description']='Secondary Roll', 'Samurai Roll', 'Scholar\'s Roll', 'Tactician\'s Roll', 'Warlock\'s Roll', 'Wizard\'s Roll', 'Allies\'s Roll', 'Avenger\'s Roll', 'Beast Roll', 'Blitzer\'s Roll', 'Bolter\'s Roll', 'Caster\'s Roll', 'Chaos Roll', 'Choral Roll', 'Companion\'s Roll', 'Corsair\'s Roll', 'Courser\'s Roll', 'Dancer\'s Roll', 'Drachen Roll', 'Evoker\'s Roll', 'Fighter\'s Roll', 'Gallant\'s Roll', 'Healer\'s Roll', 'Hunter\'s Roll', 'Magus\'s Roll', 'Miser\'s Roll', 'Monk\'s Roll', 'Ninja Roll', 'Puppet Roll', 'Rogue\'s Roll', }
    state.TertiaryRoll = M{['description']='Tertiary Roll', 'Corsair\'s Roll', 'Courser\'s Roll', 'Dancer\'s Roll', 'Drachen Roll', 'Evoker\'s Roll', 'Fighter\'s Roll', 'Gallant\'s Roll', 'Healer\'s Roll', 'Hunter\'s Roll', 'Magus\'s Roll', 'Miser\'s Roll', 'Monk\'s Roll', 'Ninja Roll', 'Puppet Roll', 'Rogue\'s Roll', 'Samurai Roll', 'Scholar\'s Roll', 'Tactician\'s Roll', 'Warlock\'s Roll', 'Wizard\'s Roll', 'Allies\'s Roll', 'Avenger\'s Roll', 'Beast Roll', 'Blitzer\'s Roll', 'Bolter\'s Roll', 'Caster\'s Roll', 'Chaos Roll', 'Choral Roll', 'Companion\'s Roll', }
    state.QuarternaryRoll = M{['description']='Quarternary Roll', 'Blitzer\'s Roll', 'Bolter\'s Roll', 'Caster\'s Roll', 'Chaos Roll', 'Choral Roll', 'Companion\'s Roll', 'Corsair\'s Roll', 'Courser\'s Roll', 'Dancer\'s Roll', 'Drachen Roll', 'Evoker\'s Roll', 'Fighter\'s Roll', 'Gallant\'s Roll', 'Healer\'s Roll', 'Hunter\'s Roll', 'Magus\'s Roll', 'Miser\'s Roll', 'Monk\'s Roll', 'Ninja Roll', 'Puppet Roll', 'Rogue\'s Roll', 'Samurai Roll', 'Scholar\'s Roll', 'Tactician\'s Roll', 'Warlock\'s Roll', 'Wizard\'s Roll', 'Allies\'s Roll', 'Avenger\'s Roll', 'Beast Roll', }

    define_roll_values()

    --add in global gear
    for k,v in pairs(globalgear) do gear[k] = v end

    gear.Artifact = {}
    gear.Artifact.Head = {}
    gear.Artifact.Body = "Laksa. Frac +2"
    gear.Artifact.Hands = {}
    gear.Artifact.Legs = {}
    gear.Artifact.Feet = {}

    gear.Relic = {}
    gear.Relic.Head = "Lanun Tricorne +1"
    gear.Relic.Body = "Lanun Frac +1"
    gear.Relic.Hands = "Lanun Gants +1"
    gear.Relic.Legs = "Lanun Trews +1"
    gear.Relic.Feet = "Lanun Bottes +2"

    gear.Empyrean = {}
    gear.Empyrean.Head = {}
    gear.Empyrean.Body = {}
    gear.Empyrean.Hands = "Chasseur's Gants +1"
    gear.Empyrean.Legs = {}
    gear.Empyrean.Feet = {}

end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Melee', 'Acc', 'Ranged')
    state.RangedMode:options('Normal', 'Acc')
    state.WeaponskillMode:options('Normal', 'Acc', 'Att', 'Mod')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT', 'MDT', 'Refresh')
    state.CP = M(false, "Capacity Points Mode")
    state.WeaponLock = M(false, 'Weapon Lock')

    state.TPBullets = M{['description']='TP Bullet', 'Bronze Bullet', 'Adlivun Bullet'}
    state.WSBullets = M{['description']='WS Bullet', 'Adlivun Bullet'}
    state.MWSBullets = M{['description']='MWS Bullet', 'Orichalc. Bullet'}
    state.QDBullets = M{['description']='QD Bullet', 'Animikii Bullet', 'Orichalc. Bullet'}
    options.ammo_warning_limit = 10

    gear.capes = {}
    gear.capes.MeleeTPCapeDW = { name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+3','"Dual Wield"+10',}}
    gear.capes.MeleeTPCapeDA = gear.capes.MeleeTPCapeDW   --also evisceration
    gear.capes.MeleeWSCape = { name="Camulus's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}}
    gear.capes.PhantomRoll = gear.capes.MeleeTPCapeDW
    gear.capes.RngLeadenCape = { name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','Weapon skill damage +10%',}}
    gear.capes.RngTPCape = gear.capes.RngLeadenCape
    gear.capes.RngWFCape = gear.capes.RngLeadenCape
    gear.capes.QDTPCape = gear.capes.RngLeadenCape
    gear.capes.FastCast = {}
    gear.capes.RngCrit = {}

    state.Weapons = M{['description'] = 'Weapon Setup', 'Savage', 'Doomsday' }
    gear.weapons = {}
    --match key to state.weapons options
    gear.weapons['Savage'] = {
        main="Hep. Sapara +1",
        sub="Blurred Knife +1",
        ranged="Anarchy +2",
    }
    gear.weapons['Doomsday'] = {
        main="Hepatizon Rapier",
        sub="Kaja Knife",
        ranged="Doomsday",
    }

    -- Additional local binds
--[[
^   Ctrl
!   Alt
@   Win
#   Apps

--]]

    send_command('bind ^- gs c cycleback mainqd')
    send_command('bind ^= gs c cycle mainqd')
    send_command('bind != gs c cycle altqd')
    send_command('bind !- gs c cycleback altqd')
    send_command('bind ^[ gs c toggle selectqdtarget')
    send_command('bind ^] gs c toggle usealtqd')

    send_command('bind ^g gs c cycle Weapons')
    send_command('bind ^l gs c toggle WeaponLock')
    send_command('bind ^q gs c qd')
    send_command('bind !q gs c qd alt')
    send_command('bind @c gs c toggle CP')
    send_command('bind @l gs c toggle LuzafRing')
    send_command('bind @2 gs c cycle MainRoll')
    send_command('bind #2 gs c cycleback MainRoll')
    send_command('bind @3 gs c cycle SecondaryRoll')
    send_command('bind #3 gs c cycleback SecondaryRoll')
    send_command('bind @4 gs c cycle TertiaryRoll')
    send_command('bind #4 gs c cycleback TertiaryRoll')
    send_command('bind @5 gs c cycle QuarternaryRoll')
    send_command('bind #5 gs c cycleback QuarternaryRoll')

    select_default_macro_book()

    send_command('wait 10; input /lockstyle on')
end


-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind ^-')
    send_command('unbind ^=')
    send_command('unbind !+')
    send_command('unbind !-')
    send_command('unbind ^[')
    send_command('unbind ^]')

    send_command('unbind ^g')
    send_command('unbind ^l')
    send_command('unbind @c')
    send_command('unbind @l')
    send_command('unbind ^q')
    send_command('unbind ^!')
    send_command('unbind @2')
    send_command('unbind #2')
    send_command('unbind @3')
    send_command('unbind #3')
    send_command('unbind @4')
    send_command('unbind #4')
    send_command('unbind @5')
    send_command('unbind #5')
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    
    -- Precast Sets

    -- Precast sets to enhance JAs
    
    --sets.precast.JA['Triple Shot'] = {body="Navarch's Frac +2"}
    sets.precast.JA['Snake Eye'] = {legs=gear.Relic.Legs}
    sets.precast.JA['Wild Card'] = {feet=gear.Relic.Feet}
    sets.precast.JA['Random Deal'] = {body=gear.Relic.Body}

    
    sets.precast.CorsairRoll = {
        head=gear.Relic.Head,
        hands=gear.Empyrean.Hands,
        legs="Desultor Tassets",
        ring1="Barataria Ring",
        back=gear.capes.PhantomRoll,
    }
    
    --sets.precast.CorsairRoll["Caster's Roll"] = set_combine(sets.precast.CorsairRoll, {legs="Navarch's Culottes +2"})
    --sets.precast.CorsairRoll["Courser's Roll"] = set_combine(sets.precast.CorsairRoll, {feet="Navarch's Bottes +2"})
    --sets.precast.CorsairRoll["Blitzer's Roll"] = set_combine(sets.precast.CorsairRoll, {head="Navarch's Tricorne +2"})
    --sets.precast.CorsairRoll["Tactician's Roll"] = set_combine(sets.precast.CorsairRoll, {body="Navarch's Frac +2"})
    --sets.precast.CorsairRoll["Allies' Roll"] = set_combine(sets.precast.CorsairRoll, {hands="Navarch's Gants +2"})
    
    sets.precast.LuzafRing = set_combine( sets.precast.CorsairRoll, {ring2="Luzaf's Ring"})
    sets.precast.FoldDoubleBust = {hands=gear.Relic.Hands}    
    sets.precast.Compensator = { ranged = "Compensator" } 

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {
        --head="Whirlpool Mask",
        --body="Iuitl Vest",
        --hands="Iuitl Wristbands",
        --legs="Nahtirah Trousers",
        --feet="Iuitl Gaiters +1"
    }
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}

    -- Fast cast sets for spells
    
    --sets.precast.FC = {head="Haruspex Hat",ear2="Loquacious Earring",hands="Thaumas Gloves",ring1="Prolix Ring"}

    --sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"})


    sets.precast.RA = {
        --ammo=gear.RAbullet,
        --head="Navarch's Tricorne +2",
        body=gear.Artifact.Body,
        hands="Carmine Fin. Ga. +1",
        back="Navarch's Mantle",
        waist="Impulse Belt",
        --legs="Nahtirah Trousers",
        feet=gear.Meghanada.Feet
    }

       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        head="Lilitu Headpiece",
        --neck="Fotia Gorget",
        ear1="Btutal Earring",
        ear2="Moonshade Earring",
        body=gear.Artifact.Body,
        hands=gear.Meghanada.Hands,
        legs="Herculean Trousers",
        feet=gear.Relic.Feet,
        ring1="Epona's Ring",
        ring2="Rajas Ring",
        back=gear.capes.MeleeWSCape,
        waist="Prosilio Belt +1"
    }

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {
        --legs="Nahtirah Trousers"
    })

    sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {
        neck="Fotia Gorget"
    })

    sets.precast.WS['Swift Blade'] = set_combine(sets.precast.WS, {
        neck="Fotia Gorget"
    })

    sets.precast.WS['Evisceration'] = set_combine( sets.precast.WS, {
        head=gear.Mummu.Head,
        body=gear.Mummu.Body,
        hands=gear.Mummu.Hands,
        legs=gear.Mummu.Legs,
        feet=gear.Mummu.Feet,
        neck="Fotia Gorget"
    })

    sets.precast.WS['Aeolian Edge'] = set_combine(sets.precast.WS, {
        --ammo=gear.QDbullet,
        --head="Wayfarer Circlet",
        neck="Stoicheion Medal",
        ear1="Friomisi Earring",
        ear2="Moonshade Earring",
        body="Samnuha Coat",
        hands="Carmine Fin. Ga. +1",
        --ring1="Stormsoul Ring",
        --ring2="Demon's Ring",
        back=gear.capes.RngLeadenCape,
        waist="Aquiline Belt",
        legs="Herculean Trousers",
        feet=gear.Relic.Feet
    })

    sets.precast.WS['Leaden Salute'] = {
        --ammo=gear.QDbullet,
        head="Pixie Hairpin +1",
        neck="Stoicheion Medal",
        ear1="Friomisi Earring",
        ear2="Moonshade Earring",
        body="Samnuha Coat",
        hands="Carmine Fin. Ga. +1",
        --ring1="Stormsoul Ring",
        --ring2="Demon's Ring",
        back=gear.capes.RngLeadenCape,
        waist="Aquiline Belt",
        legs="Herculean Trousers",
        feet=gear.Relic.Feet
    }

    sets.precast.WS['Wildfire'] = set_combine( sets.precast.WS['Leaden Salute'], {
        head=gear.Mummu.Head,
        ear2="Hecate's Earring"
    })

    sets.precast.WS['Last Stand'] = {
        --ammo=gear.WSbullet,
        head="Lilitu Headpiece",
        neck="Fotia Gorget",
        ear1="Volley Earring",
        ear2="Moonshade Earring",
        body=gear.Meghanada.Body,
        hands=gear.Meghanada.Hands,
        legs="Herculean Trousers",
        feet=gear.Relic.Feet,
        --ring1="Rajas Ring",
        --ring2="Stormsoul Ring",
        back=gear.capes.RngWFCape,
        --waist=gear.ElementalBelt
    }

    sets.precast.WS['Last Stand'].Acc = set_combine( sets.precast.WS['Last Stand'], {
    })
    
    -- Midcast Sets
    sets.midcast.FastRecast = {
        --head="Whirlpool Mask",
        --body="Iuitl Vest",
        --hands="Iuitl Wristbands",
        --legs="Manibozho Brais",
        --feet="Iuitl Gaiters +1"
    }
        
    -- Specific spells
    sets.midcast.Utsusemi = sets.midcast.FastRecast

    sets.midcast.CorsairShot = {
        --ammo=gear.QDbullet,
        --head="Blood Mask",
        body="Samnuha Coat",
        hands="Carmine Fin. Ga. +1",
        legs="Iuitl Tights +1",
        feet=gear.Relic.Feet,
        neck="Stoicheion Medal",
        ear1="Friomisi Earring",
        ear2="Hecate's Earring",
        --ring1="Hajduk Ring",
        --ring2="Demon's Ring",
        back=gear.capes.RngLeadenCape,
        waist="Aquiline Belt"
    }

    sets.midcast.CorsairShot.Acc = set_combine( sets.midcast.CorsairShot, {

    })

    sets.midcast.CorsairShot['Light Shot'] = set_combine( sets.midcast.CorsairShot,{
        --ammo=gear.MAbullet,
        head=gear.Mummu.Head,
        body=gear.Mummu.Body,
        hands=gear.Mummu.Hands,
        legs=gear.Mummu.Legs,
        feet=gear.Mummu.Feet,
        neck="Sanctity Necklace",
        back=gear.capes.QDTPCape
    })

    sets.midcast.CorsairShot['Dark Shot'] = sets.midcast.CorsairShot['Light Shot']


    -- Ranged gear
    sets.midcast.RA = {
        head=gear.Meghanada.Head,
        --neck="Ocachi Gorget",
        ear1="Volley Earring",
        ear2="Clearview Earring",
        body=gear.Mummu.Body,
        hands=gear.Meghanada.Hands,
        ring1="Longshot Ring",
        ring2="Merman's Ring",
        back=gear.capes.RngLeadenCape,
        waist="Yemaya Belt",
        legs=gear.Meghanada.Legs,
        feet="Herculean Boots"
    }

    sets.midcast.RA.Acc = set_combine( sets.midcast.RA, {
    })

    
    -- Sets to return to when not performing an action.
    
    -- Resting sets
    --sets.resting = {neck="Wiglen Gorget",ring1="Sheltered Ring",ring2="Paguroidea Ring"}
    

    -- Idle sets
    sets.idle = {
        head=gear.Relic.Head,
        body=gear.Meghanada.Body,
        hands=gear.Meghanada.Hands,
        legs="Crimson Cuisses",
        feet=gear.Relic.Feet,
        neck="Sanctity Necklace",
        waist="Dynamic Belt",
        ear1="Dudgeon Earring",
        ear2="Heartseeker Earring",
        ring1="Epona's Ring",
        ring2="Rajas Ring",
        back=gear.capes.PhantomRoll,
    }

    sets.idle.Town = set_combine( sets.idle, {

    })
    
    -- Defense sets
    sets.defense.PDT = {
        --head="Whirlpool Mask",
        --neck="Twilight Torque",
        --ear1="Clearview Earring",
        --ear2="Volley Earring",
        --body="Iuitl Vest",
        --hands="Iuitl Wristbands",
        --ring1="Defending Ring",
        --ring2=gear.DarkRing.physical,
        --back="Shadow Mantle",
        --waist="Flume Belt",
        --legs="Nahtirah Trousers",
        --feet="Iuitl Gaiters +1"
    }

    sets.defense.MDT = {
        --head="Whirlpool Mask",
        --neck="Twilight Torque",
        --ear1="Clearview Earring",
        --ear2="Volley Earring",
        --body="Iuitl Vest",
        --hands="Iuitl Wristbands",
        --ring1="Defending Ring",
        --ring2="Shadow Ring",
        --back="Engulfer Cape",
        --waist="Flume Belt",
        --legs="Nahtirah Trousers",
        --feet="Iuitl Gaiters +1"
    }
    
    --sets.Kiting = {feet="Skadi's Jambeaux +1"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    sets.engaged.Melee = {
        head=gear.Meghanada.Head,
        body="Rawhide Vest",
        hands="Adhemar Wrist. +1",
        legs="Samnuha Tights",
        feet=gear.Meghanada.Feet,
        neck="Sanctity Necklace",
        waist="Dynamic Belt",
        left_ear="Steelflash Earring",
        right_ear="Bladeborn Earring",
        left_ring="Epona's Ring",
        right_ring="Rajas Ring",
        back=gear.capes.MeleeTPCapeDW,
    }
    
    sets.engaged.Acc = set_combine( sets.engaged.Melee, {
    })

    sets.engaged.Melee.DW = set_combine( sets.engaged.Melee, {
        ear1="Dudgeon Earring",
        ear2="Heartseeker Earring"
    })
    
    sets.engaged.Acc.DW = set_combine( sets.engaged.Melee.DW, {
    })

    sets.engaged.Ranged = set_combine( sets.engaged.Melee, {
    })
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    -- Check that proper ammo is available if we're using ranged attacks or similar.
    if spell.action_type == 'Ranged Attack' or spell.type == 'WeaponSkill' or spell.type == 'CorsairShot' then
        do_bullet_checks(spell, spellMap, eventArgs)
    end

    -- gear sets
    if (spell.type == 'CorsairRoll' or spell.english == "Double-Up") and state.LuzafRing.value then
        equip(sets.precast.LuzafRing)
        if( state.UseCompensator.value ) then
            equip( sets.precast.Compensator )
        end
    elseif spell.type == 'CorsairShot' and state.CastingMode.value == 'Resistant' then
        classes.CustomClass = 'Acc'
    elseif spell.english == 'Fold' and buffactive['Bust'] == 2 then
        if sets.precast.FoldDoubleBust then
            equip(sets.precast.FoldDoubleBust)
            eventArgs.handled = true
        end
    end

    if spellMap == 'Utsusemi' then
        if buffactive['Copy Image (3)'] or buffactive['Copy Image (4+)'] then
            cancel_spell()
            add_to_chat(123, '**!! '..spell.english..' Canceled: [3+ IMAGES] !!**')
            eventArgs.handled = true
            return
        elseif buffactive['Copy Image'] or buffactive['Copy Image (2)'] then
            send_command('cancel 66; cancel 444; cancel Copy Image; cancel Copy Image (2)')
        end
    end
end


-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    if spell.type == 'CorsairRoll' and not spell.interrupted then
        display_roll_info(spell)
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Return a customized weaponskill mode to use for weaponskill sets.
-- Don't return anything if you're not overriding the default value.
function get_custom_wsmode(spell, spellMap, default_wsmode)
    if buffactive['Transcendancy'] then
        return 'Brew'
    end
end

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_handle_equipping_gear(playerStatus, eventArgs)
end

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    if newStatus == 'Engaged' and player.equipment.main == 'Chatoyant Staff' then
        state.OffenseMode:set('Ranged')
    end
end

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if state.WeaponLock.current == 'on' then
        disable('main')
        disable('sub')
        disable('ranged')
    else
        enable('main')
        enable('sub')
        enable('ranged')
    end

    if state.CP.current == 'on' then
        equip(gear.CP)
        disable('back')
    else
        enable('back')
    end

    if stateField == 'Main Roll' or
       stateField == 'Secondary Roll' or
       stateField == 'Tertiary Roll' or
       stateField == 'Quarternary Roll'
    then
        add_to_chat( 5, "[" .. stateField .. "] " .. newValue .. " provides " .. rolls[newValue].bonus )
    end

    equip(gear.weapons[state.Weapons.current])
    
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    return idleSet
end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
    local msg = ''
    
    msg = msg .. 'Off.: '..state.OffenseMode.current
    msg = msg .. ', Rng.: '..state.RangedMode.current
    msg = msg .. ', WS.: '..state.WeaponskillMode.current

    if state.DefenseMode.value ~= 'None' then
        local defMode = state[state.DefenseMode.value ..'DefenseMode'].current
        msg = msg .. ', Defense: '..state.DefenseMode.value..' '..defMode
    end
    
    if state.Kiting.value then
        msg = msg .. ', Kiting'
    end
    
    if state.PCTargetMode.value ~= 'default' then
        msg = msg .. ', Target PC: '..state.PCTargetMode.value
    end

    if state.SelectNPCTargets.value then
        msg = msg .. ', Target NPCs'
    end

    msg = msg .. ', Roll Size: ' .. ((state.LuzafRing.value and 'Large') or 'Small')
    
    add_to_chat(122, msg)

    msg = ''
    msg = msg .. 'Alt2: ' .. state.MainRoll.current .. " [".. rolls[state.MainRoll.current].bonus .."]"
    msg = msg .. ', Alt3: ' .. state.SecondaryRoll.current .. " [".. rolls[state.SecondaryRoll.current].bonus .."]"
    msg = msg .. ', Alt4: ' .. state.TertiaryRoll.current .. " [".. rolls[state.TertiaryRoll.current].bonus .."]"
    msg = msg .. ', Alt5: ' .. state.QuarternaryRoll.current .. " [".. rolls[state.QuarternaryRoll.current].bonus .."]"

    add_to_chat(122, msg)

    eventArgs.handled = true
end

function job_self_command(cmdParams, eventArgs)
    if cmdParams[1] == 'qd' then

        local doqd = ''
        local usealt = cmdParams[2] or ''
        if state.UseAltqd.value == true or 'alt' == usealt then
            doqd = state.Altqd.current
        else
            doqd = state.Mainqd.current
        end

        local doqdtarget = ''
        if state.SelectqdTarget.value == true then
            doqdtarget = '<stnpc>'
        else
            doqdtarget = '<t>'
        end

        send_command('@input /ja "'..doqd..'" '..doqdtarget)
    end

    if cmdParams[1] == 'roll' then
        local doroll = '';
        if cmdParams[2] == 'secondary' then
            doroll = state.SecondaryRoll.current
        elseif cmdParams[2] == 'tertiary' then
            doroll = state.TertiaryRoll.current
        elseif cmdParams[2] == 'quarternary' then
            doroll = state.QuarternaryRoll.current
        else
            doroll = state.MainRoll.current
        end

        send_command('@input /ja "'..doroll..'" <me>')
    end

    --gearinfo(cmdParams, eventArgs)
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function define_roll_values()
    rolls = {
        ["Corsair's Roll"]   = {lucky=5, unlucky=9, bonus="Experience Points"},
        ["Ninja Roll"]       = {lucky=4, unlucky=8, bonus="Evasion"},
        ["Hunter's Roll"]    = {lucky=4, unlucky=8, bonus="Accuracy"},
        ["Chaos Roll"]       = {lucky=4, unlucky=8, bonus="Attack"},
        ["Magus's Roll"]     = {lucky=2, unlucky=6, bonus="Magic Defense"},
        ["Healer's Roll"]    = {lucky=3, unlucky=7, bonus="Cure Potency Received"},
        ["Puppet Roll"]      = {lucky=4, unlucky=8, bonus="Pet Magic Accuracy/Attack"},
        ["Choral Roll"]      = {lucky=2, unlucky=6, bonus="Spell Interruption Rate"},
        ["Monk's Roll"]      = {lucky=3, unlucky=7, bonus="Subtle Blow"},
        ["Beast Roll"]       = {lucky=4, unlucky=8, bonus="Pet Attack"},
        ["Samurai Roll"]     = {lucky=2, unlucky=6, bonus="Store TP"},
        ["Evoker's Roll"]    = {lucky=5, unlucky=9, bonus="Refresh"},
        ["Rogue's Roll"]     = {lucky=5, unlucky=9, bonus="Critical Hit Rate"},
        ["Warlock's Roll"]   = {lucky=4, unlucky=8, bonus="Magic Accuracy"},
        ["Fighter's Roll"]   = {lucky=5, unlucky=9, bonus="Double Attack Rate"},
        ["Drachen Roll"]     = {lucky=3, unlucky=7, bonus="Pet Accuracy"},
        ["Gallant's Roll"]   = {lucky=3, unlucky=7, bonus="Defense"},
        ["Wizard's Roll"]    = {lucky=5, unlucky=9, bonus="Magic Attack"},
        ["Dancer's Roll"]    = {lucky=3, unlucky=7, bonus="Regen"},
        ["Scholar's Roll"]   = {lucky=2, unlucky=6, bonus="Conserve MP"},
        ["Bolter's Roll"]    = {lucky=3, unlucky=9, bonus="Movement Speed"},
        ["Caster's Roll"]    = {lucky=2, unlucky=7, bonus="Fast Cast"},
        ["Courser's Roll"]   = {lucky=3, unlucky=9, bonus="Snapshot"},
        ["Blitzer's Roll"]   = {lucky=4, unlucky=9, bonus="Attack Delay"},
        ["Tactician's Roll"] = {lucky=5, unlucky=8, bonus="Regain"},
        ["Allies's Roll"]    = {lucky=3, unlucky=10, bonus="Skillchain Damage"},
        ["Miser's Roll"]     = {lucky=5, unlucky=7, bonus="Save TP"},
        ["Companion's Roll"] = {lucky=2, unlucky=10, bonus="Pet Regain and Regen"},
        ["Avenger's Roll"]   = {lucky=4, unlucky=8, bonus="Counter Rate"},
    }
end

function display_roll_info(spell)
    rollinfo = rolls[spell.english]
    local rollsize = (state.LuzafRing.value and 'Large') or 'Small'

    if rollinfo then
        add_to_chat(104, spell.english..' provides a bonus to '..rollinfo.bonus..'.  Roll size: '..rollsize)
        add_to_chat(104, 'Lucky roll is '..tostring(rollinfo.lucky)..', Unlucky roll is '..tostring(rollinfo.unlucky)..'.')
    end
end


-- Determine whether we have sufficient ammo for the action being attempted.
function do_bullet_checks(spell, spellMap, eventArgs)
    local bullet_name
    local bullet_min_count = 1
    
    if spell.type == 'WeaponSkill' then
        if spell.skill == "Marksmanship" then
            if spell.element == 'None' then
                -- physical weaponskills
                bullet_name = state.WSBullets.current
            else
                -- magical weaponskills
                bullet_name = state.MWSBullets.current
            end
        else
            -- Ignore non-ranged weaponskills
            return
        end
    elseif spell.type == 'CorsairShot' then
        bullet_name = state.QDBullets.current
    elseif spell.action_type == 'Ranged Attack' then
        bullet_name = state.TPBullets.current
        if buffactive['Triple Shot'] then
            bullet_min_count = 3
        end
    end
    
    equip({ammo=bullet_name})

    local available_bullets = player.inventory[bullet_name] or player.wardrobe[bullet_name]
    
    -- If no ammo is available, give appropriate warning and end.
    if not available_bullets then
        if spell.type == 'CorsairShot' and player.equipment.ammo ~= 'empty' then
            add_to_chat(104, 'No Quick Draw ammo left.  Using what\'s currently equipped ('..player.equipment.ammo..').')
            return
        elseif spell.type == 'WeaponSkill' and player.equipment.ammo == state.TPBullets.current then
            add_to_chat(104, 'No weaponskill ammo left.  Using what\'s currently equipped (standard ranged bullets: '..player.equipment.ammo..').')
            return
        else
            add_to_chat(104, 'No ammo ('..tostring(bullet_name)..') available for that action.')
            eventArgs.cancel = true
            return
        end
    end
    
    -- Don't allow shooting or weaponskilling with ammo reserved for quick draw.
    if spell.type ~= 'CorsairShot' and bullet_name == state.QDBullets.current and available_bullets.count <= bullet_min_count then
        add_to_chat(104, 'No ammo will be left for Quick Draw.  Cancelling.')
        eventArgs.cancel = true
        return
    end
    
    -- Low ammo warning.
    if spell.type ~= 'CorsairShot' -- and state.warned.value == false
        and available_bullets.count > 1 and available_bullets.count <= options.ammo_warning_limit then
        local msg = '*****  LOW AMMO WARNING: '..bullet_name..' *****'
        --local border = string.repeat("*", #msg)
        local border = ""
        for i = 1, #msg do
            border = border .. "*"
        end
        
        add_to_chat(104, border)
        add_to_chat(104, msg)
        add_to_chat(104, border)

        state.warned:set()
    elseif available_bullets.count > options.ammo_warning_limit and state.warned then
        state.warned:reset()
    end
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    set_macro_page(1, 5)

    if player.sub_job == 'DNC' then
        classes.CustomMeleeGroups:append('DW')
    else
        classes.CustomMeleeGroups:clear()
    end

end
