-------------------------------------------------------------------------------------------------------------------
-- Initialization function that defines sets and variables to be used.
-------------------------------------------------------------------------------------------------------------------

-- NOTE: This is a work in progress, experimenting.  Expect it to change frequently, and maybe include debug stuff.

-- Last Modified: 12/24/2013 7:29:26 PM

-- IMPORTANT: Make sure to also get the Mote-Include.lua file to go with this.

function get_sets()
	-- Load and initialize the include file.
	include('Mote-Include.lua')
	init_include()
	
	-- Options: Override default values
	options.OffenseModes = {'Normal', 'Acc'}
	options.DefenseModes = {'Normal', 'Evasion', 'PDT'}
	options.WeaponskillModes = {'Normal', 'Acc', 'Att', 'Mod'}
	options.IdleModes = {'Normal'}
	options.RestingModes = {'Normal'}
	options.PhysicalDefenseModes = {'Evasion', 'PDT'}
	options.MagicalDefenseModes = {'MDT'}

	state.Defense.PhysicalMode = 'Evasion'
	
	
	--leftDarkRing = {name="Dark Ring",augments={"Physical Damage Taken -6%", "Magical Damage Taken -3%", "Spell Interruption Rate Down 5%"}}
	--rightDarkRing = {name="Dark Ring",augments={"Physical Damage Taken -5%", "Magical Damage Taken -3%"}}

	--------------------------------------
	-- Start defining the sets
	--------------------------------------
	
	-- Precast Sets
	sets.precast = {}
	
	-- Precast sets to enhance JAs
	sets.precast.JA = {}
	
	sets.precast.JA.Benediction = {feet="Cleric's Briault +2"}

	-- Waltz set (chr and vit)
	sets.precast.Waltz = {
		head="Nahtirah Hat",ear1="Roundel Earring",
		body="Gendewitha Bliaut",hands="Yaoyotl Gloves",
		back="Refraction Cape",legs="Gendewitha Spats",feet="Gendewitha Galoshes"}
	
	-- Fast cast sets for spells
	
	-- default fast cast
	sets.precast.FC = {head="Nahtirah Hat",neck="Orison Locket",ear2="Loquacious Earring",
		hands="Gendewitha Gages",ring1="Prolix Ring",
		back="Swith Cape",legs="Orvail Pants",feet="Chelona Boots +1"}
		
	sets.precast.FC.CureSolace = {main="Tamaxchi",sub="Genbu's Shield",ammo="Incantor's Stone",
		head="Theophany Cap",neck="Aceso's Choker",ear1="Orison Earring",ear2="Loquacious Earring",
		body="Orison Bliaud +2",hands="Bokwus Gloves",ring1="Prolix Ring",ring2="Mediator's Ring",
		back="Pahtli Cape",waist="Witful Belt",legs="Orison Pantaloons +2",feet="Cure Clogs"}

	sets.precast.FC.Cure = {main="Tamaxchi",sub="Genbu's Shield",ammo="Impatiens",
		head="Nahtirah Hat",neck="Orison Locket",ear1="Orison Earring",ear2="Loquacious Earring",
		body="Heka's Kalasiris",hands="Bokwus Gloves",ring1="Prolix Ring",ring2="Mediator's Ring",
		back="Pahtli Cape",waist="Witful Belt",legs="Orison Pantaloons +2",feet="Gendewitha Galoshes"}

	sets.precast.FC.Curaga = {main="Tamaxchi",sub="Genbu's Shield",ammo="Impatiens",
		head="Nahtirah Hat",neck="Orison Locket",ear1="Orison Earring",ear2="Loquacious Earring",
		body="Heka's Kalasiris",hands="Bokwus Gloves",ring1="Prolix Ring",ring2="Mediator's Ring",
		back="Pahtli Cape",waist="Witful Belt",legs="Orison Pantaloons +2",feet="Gendewitha Galoshes"}

	sets.precast.FC.CureMelee = {ammo="Incantor Stone",
		head="Gendewitha Caubeen",neck="Aceso's Choker",ear1="Orison Earring",ear2="Loquacious Earring",
		body="Heka's Kalasiris",hands="Bokwus Gloves",ring1="Prolix Ring",ring2="Mediator's Ring",
		back="Pahtli Cape",waist="Witful Belt",legs="Orison Pantaloons +2",feet="Gendewitha Galoshes"}

	sets.precast.FC.EnhancingMagic = {head="Nahtirah Hat",neck="Orison Locket",ear2="Loquac. Earring",
		hands="Gendewitha Gages",ring1="Prolix Ring",
		back="Swith Cape",waist="Siegel Sash",legs="Orvail Pants",feet="Chelona Boots +1"}

	sets.precast.FC.HealingMagic = {main="Beneficus",sub="Genbu's Shield",
		neck="Colossus's Torque",
		body="Orison Bliaud +2",hands="Healer's Mitts",ring1="Sirona's Ring",ring2="Ephedra Ring",
		back="Tempered Cape",legs="Cleric's Pantaloons +2"}
		

       
	-- Magian staves with cast time reduction, by element
	--sets.precast.FC.Thunder = {main='Apamajas I'}
	--sets.precast.FC.Fire = {main='Atar I'}
	
	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {
		head="Nahtirah Hat",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Gendewitha Bliaut",hands="Yaoyotl Gloves",ring1="Rajas Ring",ring2="K'ayres Ring",
		back="Tuilha Cape",legs="Gendewitha Spats",feet="Gendewitha Galoshes"}
	
	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS['Hexa Strike'] = {
		head="Nahtirah Hat",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Gendewitha Bliaut",hands="Yaoyotl Gloves",ring1="Rajas Ring",ring2="K'ayres Ring",
		back="Tuilha Cape",waist="Light Belt",legs="Gendewitha Spats",feet="Gendewitha Galoshes"}

	sets.precast.WS['Mystic Boon'] = {
		head="Nahtirah Hat",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Gendewitha Bliaut",hands="Yaoyotl Gloves",ring1="Rajas Ring",ring2="K'ayres Ring",
		back="Tuilha Cape",legs="Gendewitha Spats",feet="Gendewitha Galoshes"}

	sets.precast.WS['Flash Nova'] = {
		head="Nahtirah Hat",neck="Stoicheion Medal",ear1="Friomisi Earring",ear2="Hecate's Earring",
		body="Bokwus Robe",hands="Yaoyotl Gloves",ring1="Rajas Ring",ring2="Strendu Ring",
		back="Toro Cape",waist="Thunder Belt",legs="Gendewitha Spats",feet="Gendewitha Galoshes"}
	
	
	-- Midcast Sets
	sets.midcast = {}
	
	sets.midcast.FastRecast = {
		head="Nahtirah Hat",ear2="Loquacious Earring",
		body="Goliard Saio",hands="Gendewitha Gages",ring1="Prolix Ring",
		back="Swith Cape",waist="Goading Belt",legs="Theophany Pantaloons",feet="Gendewitha Galoshes"}
		
	-- Specific spells
	sets.midcast.Cursna = {
		head="Orison Cap +2",neck="Malison Medallion",
		hands="Hieros Mittens",ring1="Ephedra Ring",
		legs="Theophany Pantaloons",feet="Gendewitha Galoshes"}

	sets.midcast.Stoneskin = {
		head="Nahtirah Hat",neck="Orison Locket",ear2="Loquacious Earring",
		body="Gendewitha Bliaut",hands="Gendewitha Gages",
		back="Swith Cape",waist="Siegel Sash",feet="Gendewitha Galoshes"}

	sets.midcast.Auspice = {feet="Orison Duckbills +2"}

	-- Spell classes
	sets.midcast.Barspell = {main="Beneficus",sub="Genbu's Shield",
		head="Orison Cap +2",neck="Colossus's Torque",
		body="Orison Bliaud +2",hands="Orison Mitts +2",
		waist="Cascade Belt",legs="Cleric's Pantaloons +2",feet="Orison Duckbills +2"}

	sets.midcast.Regen = {
		body="Cleric's Briault",hands="Orison Mitts +2",
		legs="Theophany Pantaloons"}

	sets.midcast.StatusRemoval = {
		head="Orison Cap +2",legs="Orison Pantaloons +2"}

	sets.midcast['Divine Caress'] = {hands="Orison Mitts +2"}

	sets.midcast.Protectra = {ring1="Sheltered Ring"}

	sets.midcast.Shellra = {ring1="Sheltered Ring",legs="Cleric's Pantaloons +2"}

	-- Spell skill categories
	sets.midcast.EnhancingMagic = {main="Beneficus",sub="Genbu's Shield",
		neck="Colossus's Torque",
		body="Manasa Chasuble",hands="Ayao's Gages",
		waist="Cascade Belt",legs="Cleric's Pantaloons +2",feet="Orison Duckbills +2"}

	sets.midcast.DivineMagic = {main="Tamaxchi",sub="Genbu's Shield",
		head="Nahtirah Hat",neck="Colossus's Torque",ear1="Psystorm Earring",ear2="Lifestorm Earring",
		body="Manasa Chasuble",hands="Yaoyotl Gloves",ring2="Mediator's Ring",
		back="Refraction Cape",waist="Demonry Sash",legs="Theophany Pantaloons +2",feet="Orison Duckbills +2"}

	sets.midcast.DarkMagic = {main="Tamaxchi", sub="Genbu's Shield",
		head="Nahtirah Hat",neck="Aesir Torque",ear1="Psystorm Earring",ear2="Lifestorm Earring",
		body="Manasa Chasuble",hands="Yaoyotl Gloves",ring1="Strendu Ring",ring2="Mediator's Ring",
		back="Refraction Cape",waist="Demonry Sash",legs="Portent Pants",feet="Bokwus Boots"}


	-- Custom spell classes
	sets.midcast.MndEnfeebles = {main="Tamaxchi", sub="Genbu's Shield",
		head="Nahtirah Hat",neck="Weike Torque",ear1="Psystorm Earring",ear2="Lifestorm Earring",
		body="Manasa Chasuble",hands="Yaoyotl Gloves",ring1="Aquasoul Ring",ring2="Mediator's Ring",
		back="Refraction Cape",waist="Demonry Sash",legs="Gendewitha Spats",feet="Bokwus Boots"}

	sets.midcast.IntEnfeebles = {main="Tamaxchi", sub="Genbu's Shield",
		head="Nahtirah Hat",neck="Weike Torque",ear1="Psystorm Earring",ear2="Lifestorm Earring",
		body="Manasa Chasuble",hands="Yaoyotl Gloves",ring1="Icesoul Ring",ring2="Mediator's Ring",
		back="Refraction Cape",waist="Demonry Sash",legs="Orvail Pants",feet="Bokwus Boots"}

	
	-- Sets to return to when not performing an action.
	
	-- Resting sets
	sets.resting = {main=staffs.HMP, 
		head="Nefer Khat +1",
		body="Heka's Kalasiris",hands="Serpentes Cuffs",
		waist="Austerity Belt",legs="Nares Trews",feet="Chelona Boots +1"}
	

	-- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
	sets.idle = {main="Tamaxchi", sub="Genbu's Shield",ammo="Incantor Stone",
		head="Gendewitha Caubeen",neck="Wiglen Gorget",ear1="Bloodgem Earring",ear2="Loquacious Earring",
		body="Gendewitha Bliaut",hands="Gendewitha Gages",ring1='Dark Ring',ring2='Dark Ring',
		back="Umbra Cape",waist="Witful Belt",legs="Nares Trews",feet="Herald's Gaiters"}

	sets.idle.Town = {main="Tamaxchi", sub="Genbu's Shield",ammo="Incantor Stone",
		head="Gendewitha Caubeen",neck="Wiglen Gorget",ear1="Bloodgem Earring",ear2="Loquacious Earring",
		body="Gendewitha Bliaut",hands="Gendewitha Gages",ring1="Sheltered Ring",ring2="Paguroidea Ring",
		back="Umbra Cape",waist="Witful Belt",legs="Nares Trews",feet="Herald's Gaiters"}
	
	sets.idle.Field = {main="Tamaxchi", sub="Genbu's Shield",ammo="Incantor Stone",
		head="Nefer Khat +1",neck="Wiglen Gorget",ear1="Bloodgem Earring",ear2="Loquacious Earring",
		body="Heka's Kalasiris",hands="Serpentes Cuffs",ring1="Sheltered Ring",ring2="Paguroidea Ring",
		back="Umbra Cape",waist="Witful Belt",legs="Nares Trews",feet="Herald's Gaiters"}

	sets.idle.Field.PDT = {main="Tamaxchi", sub="Genbu's Shield",ammo="Incantor Stone",
		head="Gendewitha Caubeen",neck="Twilight Torque",ear1="Bloodgem Earring",ear2="Loquacious Earring",
		body="Gendewitha Bliaut",hands="Gendewitha Gages",ring1="Dark Ring",ring2="Dark Ring",
		back="Umbra Cape",waist="Witful Belt",legs="Gendewitha Spats",feet="Gendewitha Galoshes"}
		
	sets.idle.Weak = {main="Tamaxchi",sub="Genbu's Shield",ammo="Incantor Stone",
		head="Gendewitha Caubeen",neck="Twilight Torque",ear1="Bloodgem Earring",
		body="Gendewitha Bliaut",hands="Yaoyotl Gloves",ring1="Dark Ring",ring2="Meridian Ring",
		back="Umbra Cape",waist="Witful Belt",legs="Nares Trews",feet="Gendewitha Galoshes"}
	
	sets.Owleyes = {main="Owleyes", sub="Genbu's Shield"}
	
	-- Defense sets
	sets.defense = {}

	sets.defense.PDT = {main=staffs.PDT,sub="Achaq Grip",
		head="Gendewitha Caubeen",neck="Twilight Torque",
		body="Gendewitha Bliaut",hands="Gendewitha Gages",ring1=leftDarkRing,ring2=rightDarkRing,
		back="Umbra Cape",legs="Gendewitha Spats",feet="Gendewitha Galoshes"}

	sets.defense.MDT = {main=staffs.PDT,sub="Achaq Grip",
		head="Nahtirah Hat",neck="Twilight Torque",
		body="Gendewitha Bliaut",hands="Yaoyotl Gloves",ring1=leftDarkRing,ring2="Shadow Ring",
		back="Engulfer Cape",legs="Gendewitha Spats",feet="Gendewitha Galoshes"}


	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion
	
	-- Basic set for if no TP weapon is defined.
	sets.engaged = {
		head="Zelus Tiara",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Gendewitha Bliaut",hands="Yaoyotl Gloves",ring1="Rajas Ring",ring2="K'ayres Ring",
		back="Umbra Cape",waist="Goading Belt",legs="Gendewitha Spats",feet="Gendewitha Galoshes"}

	-- Sets with weapons defined.
	sets.engaged.Acc = {
		head="Nahtirah Hat",neck="Peacock Charm",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Gendewitha Bliaut",hands="Buremte Gloves",ring1="Rajas Ring",ring2="K'ayres Ring",
		back="Umbra Cape",waist="Goading Belt",legs="Gendewitha Spats",feet="Gendewitha Galoshes"}


	windower.send_command('input /macro book 14;wait .1;input /macro set 4')
	gearswap_binds_on_load()

	windower.send_command('bind ^- gs c toggle target')
	windower.send_command('bind ^= gs c cycle targetmode')
end

-- Called when this job file is unloaded (eg: job change)
function file_unload()
	--spellcast_binds_on_unload()
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks that are called to process player actions at specific points in time.
-------------------------------------------------------------------------------------------------------------------

-- Return true if we handled the precast work.  Otherwise it will fall back
-- to the general precast() code in Mote-Include.
function job_precast(spell, action, spellMap)

	if spell.english == "Paralyna" and buffactive.Paralyzed then
		-- no gear swaps if we're paralyzed, to avoid blinking while trying to remove it.
		return true
	end

	classes.CustomClass = get_spell_class(spell, action, spellMap)
end


function job_post_precast(spell, action, spellMap, useMidcastGear)
	-- Apply Divine Caress boosting items as highest priority over other gear, if applicable.
	if useMidcastGear and spellMap == 'StatusRemoval' and buffactive['Divine Caress'] then
		equip(sets.midcast['Divine Caress'])
	end
end

-- Return true if we handled the midcast work.  Otherwise it will fall back
-- to the general midcast() code in Mote-Include.
function job_midcast(spell, action, spellMap)
	-- Always use FastRecast as the base layer
	equip(sets.midcast.FastRecast)
	
	classes.CustomClass = get_spell_class(spell, action, spellMap)
end

function job_post_midcast(spell, action, spellMap)
	-- Apply Divine Caress boosting items as highest priority over other gear, if applicable.
	if spellMap == 'StatusRemoval' and buffactive['Divine Caress'] then
		equip(sets.midcast['Divine Caress'])
	end
end

-- Return true if we handled the aftercast work.  Otherwise it will fall back
-- to the general aftercast() code in Mote-Include.
function job_aftercast(spell, action)
	return false
end


-------------------------------------------------------------------------------------------------------------------
-- Customization hooks for idle and melee sets, after they've been automatically constructed.
-------------------------------------------------------------------------------------------------------------------

function customize_idle_set(idleSet)
	if player.mpp < 90 and state.IdleMode == "Normal" and state.Defense.Active == false then
		idleSet = set_combine(idleSet, sets.Owleyes)
	end
	
	return idleSet
end


-------------------------------------------------------------------------------------------------------------------
-- General hooks for other events.
-------------------------------------------------------------------------------------------------------------------

-- Called when the player's status changes.
function status_change(newStatus,oldStatus)
	-- Disable weapon swaps when engaged
	if newStatus == 'Engaged' then
		disable('main','sub')
	elseif oldStatus == 'Engaged' then
		enable('main','sub')
	end
end

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain_or_loss == 'gain' or 'loss', depending on the buff state change
function buff_change(buff,gain_or_loss)
	if buff == 'Afflatus Solace' then
		if gain_or_loss == 'gain' then
			afflatusSolace = true
		else
			afflatusSolace = false
		end
	end
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------

-- Called for direct player commands.
function job_self_command(cmdParams)
	if cmdParams[1] == 'update' and cmdParams[2] == 'user' then
		if not buffactive['Afflatus Solace'] then
			windower.send_command('input /ja "Afflatus Solace" <me>')
		elseif not (buffactive['Light Arts'] or buffactive['Addendum: White']) then
			windower.send_command('input /ja "Light Arts" <me>')
		end
	end
	return false
end


-- Function to display the current relevant user state when doing an update.
-- Return true if display was handled, and you don't want the default info shown.
function display_current_job_state()
	local defMode = state.Defense.PhysicalMode
	if state.Defense.Type == 'Magical' then
		defMode = state.Defense.MagicalMode
	end
	
	add_to_chat(121,'Casting ['..state.CastingMode..'], Idle ['..state.IdleMode..'], '..
		'Defense ['..state.Defense.Type..'/'..defMode..']:'..on_off_names[state.Defense.Active]:upper()..', '..
		'Melee ['..state.OffenseMode..'/'..state.DefenseMode..']')

	return true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function get_spell_class(spell, action, spellMap)
	if action.type == 'Magic' then
		if spell.skill == "EnfeeblingMagic" then
			if spell.type == "WhiteMagic" then
				return "MndEnfeebles"
			else
				return "IntEnfeebles"
			end
		else
			if spellMap == "Cure" or spellMap == "Curaga" then
				if player.status == 'Engaged' then
					return "CureMelee"
				elseif afflatusSolace and spellMap == 'Cure' then
					return "CureSolace"
				end
			end
		end
	end
	
	return nil
end
