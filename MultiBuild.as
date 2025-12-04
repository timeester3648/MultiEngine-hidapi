void main(MultiBuild::Workspace& workspace) {	
	auto project = workspace.create_project(".");
	auto properties = project.properties();

	project.name("hidapi");
	properties.binary_object_kind(MultiBuild::BinaryObjectKind::eStaticLib);
	project.license("./LICENSE-bsd.txt");
	
	project.include_own_required_includes(true);
	project.add_required_project_include({
		"./hidapi"
	});

	properties.include_directories("./hidapi");
	properties.files("./hidapi/*.h");

	{
		MultiBuild::ScopedFilter _(project, "config.platform:Windows");
		properties.files("./windows/hid.c");
	}

	{
		MultiBuild::ScopedFilter _(project, "config.platform:Linux");
		properties.files("./linux/hid.c");
	}

	{
		MultiBuild::ScopedFilter _(project, "config.platform:MacOS");
		properties.files("./mac/hid.c");
	}
}