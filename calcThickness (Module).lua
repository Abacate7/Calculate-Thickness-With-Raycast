return function(part: Part, hitPosition: Vector3, normal: Vector3, rayOrigin: Vector3): Vector3
	local incomingRay = (rayOrigin - hitPosition).Unit

	local cosTheta = incomingRay:Dot(normal)
	local angleOfImpact = math.acos(cosTheta)
	local angleInDegrees = math.deg(angleOfImpact)

	local partSize = part.Size

	local localVectors = {
		X = part.CFrame.RightVector,
		Y = part.CFrame.UpVector,
		Z = part.CFrame.LookVector
	}
	local dotProducts = {
		X = math.abs(normal:Dot(localVectors.X)),
		Y = math.abs(normal:Dot(localVectors.Y)),
		Z = math.abs(normal:Dot(localVectors.Z))
	}

	local chosenAxisSize

	if dotProducts.X > dotProducts.Y and dotProducts.X > dotProducts.Z then
		chosenAxisSize = partSize.X
	elseif dotProducts.Y > dotProducts.X and dotProducts.Y > dotProducts.Z then
		chosenAxisSize = partSize.Y
	else
		chosenAxisSize = partSize.Z
	end

	local thickness = chosenAxisSize / cosTheta

	return thickness
end
