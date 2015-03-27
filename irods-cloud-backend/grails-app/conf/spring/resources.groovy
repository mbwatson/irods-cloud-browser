// Place your Spring DSL code here
beans = {


	loginController(org.irods.jargon.idrop.web.controllers.LoginController) { irodsAccessObjectFactory = ref("irodsAccessObjectFactory") }




	/*
	 * Services
	 */

	authenticationService(org.irods.jargon.idrop.web.services.AuthenticationService)  { irodsAccessObjectFactory = ref("irodsAccessObjectFactory") }

	/*virtualCollectionFactory(idrop.web3.virtualCollectionFactoryImpl) { irodsAccessObjectFactory = ref("irodsAccessObjectFactory") }
	 virtualCollectionService(org.irods.jargon.idrop.web.services.VirtualCollectionService)  { irodsAccessObjectFactory = ref("irodsAccessObjectFactory") }*/

}
