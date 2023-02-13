---@enum StaxCharacterComponents
StaxCharacterComponents = {
  face = 0,
  mask = 1,
  hair = 2,
  torso = 3,
  legs = 4,
  bags = 5,
  shoes = 6,
  accessories = 7,
  undershirts = 8,
  kevlar = 9,
  badges = 10,
  torso2 = 11
}

---@enum StaxCharacterFeatures
StaxCharacterFeatures = {
  nose_width = 0,
  nose_peak_height = 1,
  nose_peak_length = 2,
  nose_bone_height = 3,
  nose_peak_lowering = 4,
  nose_bone_twist = 5,
  eyebrow_height = 6,
  eyebrow_forward = 7,
  cheek_bone_height = 8,
  cheek_bone_width = 9,
  cheek_width = 10,
  eye_openings = 11,
  lip_thickness = 12,
  jaw_bone_width = 13,
  jaw_bone_length = 14,
  chin_bone_lowering = 15,
  chin_bone_length = 16,
  chin_bone_width = 17,
  chin_hole = 18,
  neck_thickness = 19
}

---@enum StaxCharacterOverlays
StaxCharacterOverlays = {
  blemishes = 0,
  facial_hair = 1,
  eyebrows = 2,
  ageing = 3,
  makeup = 4,
  blush = 5,
  complexion = 6,
  sun_damage = 7,
  lipstick = 8,
  moles_freckles = 9,
  chest_hair = 10,
  body_blemishes = 11,
  add_body_blemishes = 12
}

---@enum StaxCharacterProps
StaxCharacterProps = {
  hats = 0,
  glasses = 1,
  ears = 2,
  watches = 6,
  bracelets = 7
}

local Events = Stax.Singletons.Events

---@class StaxLocalPlayer
---@field public Data { Handle: number, Model: number}
StaxLocalPlayer = {}
StaxLocalPlayer.Data = {
  Handle = PlayerPedId(),
  Model = GetEntityModel(PlayerPedId())
}

--- FUNCTIONS

--- Sets the local players ped model
---@param model string | number
function StaxLocalPlayer:SetModel(model)
  local timeout = GetGameTimer() + 10000

  if type(model) == "string" then model = GetHashKey(model) end

  if not IsModelInCdimage(model) then
    while not HasModelLoaded(model) do
      if GetGameTimer() > timeout  then
        return nil
      end
      Citizen.Wait(0)
    end
  end

  SetPlayerModel(PlayerId(), model)

  TriggerEvent("STAX::Core::Client::LocalPlayer::ModelUpdated", model)

  return nil
end

--- Gets the model of your players ped model
---@return number
function StaxLocalPlayer:GetModel()
  return self.Data.Model
end

--- Gets your players ped handle
---@return number
function StaxLocalPlayer:GetPed()
  return self.Data.Handle
end

--- Sets the full component of the players ped
---@param component StaxCharacterComponents
---@param drawable number
---@param texture number
---@param palette number
function StaxLocalPlayer:SetComponent(component, drawable, texture, palette)
  SetPedComponentVariation(self.Data.Handle, component, drawable, texture, palette)
end

--- Gets the drawable variation of the players ped component
---@param component StaxCharacterComponents
---@return number
function StaxLocalPlayer:GetComponentDrawable(component)
  return GetPedDrawableVariation(self.Data.Handle, component)
end

--- Gets the texture variation of the players ped component
---@param component StaxCharacterComponents
---@return number
function StaxLocalPlayer:GetComponentTexture(component)
  return GetPedTextureVariation(self.Data.Handle, component)
end

-- SetPedPropIndex(Ped* ped, int* componentId, int* drawableId, int* textureId, BOOL* attach)

--- Sets the full prop of the players ped
---@param prop StaxCharacterProps
---@param drawable number
---@param texture number
---@param attach boolean
function StaxLocalPlayer:SetProp(prop, drawable, texture, attach)
  SetPedPropIndex(self.Data.Handle, prop, drawable, texture, attach)
end

--- Gets the players ped prop drawable variation
---@param prop StaxCharacterProps
function StaxLocalPlayer:GetProp(prop)
  return GetPedPropIndex(self.Data.Handle, prop)
end

--- Gets the players ped prop drawable variation
---@param prop StaxCharacterProps
function StaxLocalPlayer:GetPropTexture(prop)
  return GetPedPropTextureIndex(self.Data.Handle, prop)
end


--- EVENTS

--- Fires when the model for the local player is changed
---@param ped number
---@param model string | number
Events.CreateEvent("STAX::Core::Client::LocalPlayer::ModelUpdated", function(ped, model)
  StaxLocalPlayer.Data.Handle = ped
  StaxLocalPlayer.Data.Model = model
end)