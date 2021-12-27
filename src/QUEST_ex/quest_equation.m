function residual = quest_equation(lambda, B, z, S)

ka = trace( adjoint(S) );
residual = (lambda^2-trace(B)^2+ka)*(lambda^2-trace(B)^2-norm(z)^2) ... 
    -(lambda-trace(B))*(z'*S*z+det(S)) -z'*S*S*z;